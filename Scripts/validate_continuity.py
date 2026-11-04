#!/usr/bin/env python3
"""Validate continuity schemas, provenance, references, hashes, and receipts."""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path
from typing import Any

from continuity_lib import (
    ROOT,
    check_markdown_links,
    load_json_yaml,
    verify_hash_manifest,
)

SHA_RE = re.compile(r"^[0-9a-f]{40}$")
ALLOWED_CHECKS = {
    "passed",
    "not_applicable",
    "pending",
    "not_run",
    "blocked",
}


def validate_checkpoint(root: Path) -> tuple[list[str], list[str]]:
    errors: list[str] = []
    warnings: list[str] = []
    path = root / "manifests/CURRENT_CHECKPOINT.yaml"
    try:
        checkpoint = load_json_yaml(path)
    except ValueError as error:
        return [str(error)], warnings
    if checkpoint.get("schema_version") != 1:
        errors.append("checkpoint schema_version must be 1")
    if not re.fullmatch(r"UCK-\d{4}-\d{2}-\d{2}-\d{3}", str(checkpoint.get("checkpoint_id", ""))):
        errors.append("checkpoint_id must match UCK-YYYY-MM-DD-NNN")
    if checkpoint.get("checkpoint_status") not in {"initialized_candidate", "canonical_partial"}:
        errors.append("checkpoint_status must explicitly identify candidate or partial canonical state")
    if not checkpoint.get("created_at"):
        errors.append("checkpoint created_at is missing")

    repositories = checkpoint.get("repositories")
    if not isinstance(repositories, dict):
        errors.append("checkpoint repositories must be an object")
        repositories = {}
    for key in ("standing_algebra", "icg", "kernel"):
        source = repositories.get(key)
        if not isinstance(source, dict):
            errors.append(f"checkpoint missing repository node: {key}")
            continue
        status = source.get("status")
        if not status:
            errors.append(f"{key} repository status is missing")
        commit = source.get("commit")
        if commit and not SHA_RE.fullmatch(str(commit)):
            errors.append(f"{key} commit is malformed")
        if status == "unavailable" and not source.get("identity_note"):
            warnings.append(f"{key} is unavailable without an identity explanation")
        if not source.get("url") and not source.get("identity_note"):
            errors.append(f"{key} must have a URL or explicit identity_note")

    validation = checkpoint.get("validation")
    if not isinstance(validation, dict) or not validation:
        errors.append("checkpoint validation receipts are missing")
    else:
        for name, result in validation.items():
            if not isinstance(result, dict) or result.get("status") not in ALLOWED_CHECKS:
                errors.append(f"invalid validation status for {name}")
            elif result.get("status") == "passed" and not result.get("receipt_id"):
                errors.append(f"passed validation {name} has no receipt_id")
            elif result.get("status") in {"pending", "not_run", "blocked"}:
                warnings.append(f"validation {name} is {result['status']}")

    if not isinstance(checkpoint.get("rollback"), dict) or not checkpoint["rollback"].get("instructions"):
        errors.append("checkpoint rollback instructions are missing")
    if not isinstance(checkpoint.get("residuals"), list):
        errors.append("checkpoint residuals must be a list")
    elif any(
        not isinstance(item, dict) or not item.get("id") or not item.get("description")
        for item in checkpoint["residuals"]
    ):
        errors.append("checkpoint has an incomplete residual entry")
    if not isinstance(checkpoint.get("supersedes"), list):
        errors.append("checkpoint supersedes must be a list")
    return errors, warnings


def validate_corpus(root: Path) -> list[str]:
    errors: list[str] = []
    try:
        manifest = load_json_yaml(root / "manifests/CORPUS_MANIFEST.yaml")
    except ValueError as error:
        return [str(error)]
    sources = manifest.get("sources")
    if not isinstance(sources, list) or not sources:
        return ["corpus manifest has no sources"]
    ids: set[str] = set()
    for source in sources:
        if not isinstance(source, dict):
            errors.append("corpus source entry is not an object")
            continue
        source_id = source.get("id")
        if not source_id or source_id in ids:
            errors.append(f"missing or duplicate corpus source id: {source_id}")
        ids.add(source_id)
        if not source.get("provenance"):
            errors.append(f"{source_id}: provenance is missing")
        if not source.get("status"):
            errors.append(f"{source_id}: status is missing")
        if source.get("path"):
            relative = Path(source["path"])
            if relative.is_absolute() or ".." in relative.parts:
                errors.append(f"{source_id}: unsafe corpus path: {source['path']}")
                continue
            target = root / relative
            if not target.is_file():
                errors.append(f"{source_id}: corpus path does not exist: {source['path']}")
            if source.get("sha256") and target.is_file():
                from continuity_lib import sha256_file
                if sha256_file(target) != source["sha256"]:
                    errors.append(f"{source_id}: corpus hash mismatch")
        elif source.get("status") not in {"unavailable", "not_supplied"}:
            errors.append(f"{source_id}: non-unavailable source requires a path")
    return errors


def validate_source_repositories(root: Path) -> list[str]:
    errors: list[str] = []
    path = root / "manifests/SOURCE_REPOSITORIES.json"
    try:
        document = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        return [f"invalid source repository manifest: {error}"]
    if document.get("schema_version") != 1:
        errors.append("source repository manifest schema_version must be 1")
    repositories = document.get("repositories")
    if not isinstance(repositories, dict):
        return errors + ["source repository manifest repositories must be an object"]
    for key in (
        "standing_algebra",
        "icg",
        "kernel",
        "non_domination_governance_kernel",
        "i2os_structural_admissibility",
    ):
        source = repositories.get(key)
        if not isinstance(source, dict):
            errors.append(f"source repository manifest missing node: {key}")
            continue
        if not source.get("status") or not source.get("identity_note"):
            errors.append(f"{key}: status and identity_note are required")
        commit = source.get("commit")
        if commit is not None and not SHA_RE.fullmatch(str(commit)):
            errors.append(f"{key}: malformed commit SHA")
        source_paths = source.get("path")
        if source_paths is None:
            continue
        if isinstance(source_paths, str):
            source_paths = [source_paths]
        if not isinstance(source_paths, list):
            errors.append(f"{key}: path must be a string, list, or null")
            continue
        for source_path in source_paths:
            relative = Path(source_path)
            if relative.is_absolute() or ".." in relative.parts:
                errors.append(f"{key}: unsafe repository path: {source_path}")
            elif not (root / relative).exists():
                errors.append(f"{key}: repository path missing: {source_path}")
    return errors


def validate_receipts(root: Path) -> list[str]:
    errors: list[str] = []
    path = root / "manifests/VALIDATION_RECEIPTS.json"
    try:
        document = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        return [f"invalid validation receipts: {error}"]
    receipts = document.get("receipts", {})
    for check, receipt_id in document.get("required_receipts", {}).items():
        entry = receipts.get(receipt_id)
        if entry is None:
            errors.append(f"required receipt missing: {check} -> {receipt_id}")
        elif not isinstance(entry, dict):
            errors.append(f"receipt {receipt_id} must be an object")
        elif not all(entry.get(key) for key in ("status", "command", "observed_at", "source")):
            errors.append(f"receipt {receipt_id} missing status/command/observed_at/source")
        elif entry["status"] == "passed" and not entry.get("result"):
            errors.append(f"passed receipt {receipt_id} has no observed result")
    return errors


def validate_residuals(root: Path) -> list[str]:
    text = (root / "continuity/OPEN_RESIDUALS.md").read_text(encoding="utf-8")
    errors: list[str] = []
    ids: set[str] = set()
    for line in text.splitlines():
        if not line.startswith("| R-"):
            continue
        fields = [part.strip() for part in line.strip("|").split("|")]
        if len(fields) < 4:
            errors.append(f"incomplete residual row: {line}")
            continue
        residual_id = fields[0]
        if residual_id in ids:
            errors.append(f"duplicate residual id: {residual_id}")
        ids.add(residual_id)
        if fields[1] == "closed" and not fields[3]:
            errors.append(f"closed residual {residual_id} has no closure evidence")
    if not ids:
        errors.append("open residual register has no entries")
    return errors


def validate_dependency_references(root: Path) -> list[str]:
    graph = (root / "continuity/DEPENDENCY_GRAPH.md").read_text(encoding="utf-8")
    errors: list[str] = []
    for path in re.findall(r"`((?:\.\.?/)?[A-Za-z0-9_. /-]+\.(?:md|lean|v|smt2|py|yml|yaml|json))`", graph):
        candidate = (root / Path(path)).resolve()
        try:
            candidate.relative_to(root.resolve())
        except ValueError:
            errors.append(f"dependency path escapes repository: {path}")
            continue
        if not candidate.exists():
            errors.append(f"dependency path missing: {path}")
    return errors


def validate_duplicate_checkpoint_ids(root: Path) -> list[str]:
    checkpoint = load_json_yaml(root / "manifests/CURRENT_CHECKPOINT.yaml")
    expected = checkpoint["checkpoint_id"]
    ids = re.findall(
        r"Checkpoint ID:\*{0,2}\s*`?([^`\s]+)",
        (root / "continuity/CURRENT_STATE.md").read_text(encoding="utf-8"),
    )
    if ids != [expected]:
        return [f"CURRENT_STATE checkpoint ID declarations mismatch manifest: {ids!r}"]
    return []


def validate(root: Path) -> dict[str, Any]:
    errors: list[str] = []
    warnings: list[str] = []
    checkpoint_errors, checkpoint_warnings = validate_checkpoint(root)
    errors.extend(checkpoint_errors)
    warnings.extend(checkpoint_warnings)
    for check in (
        validate_corpus(root),
        validate_source_repositories(root),
        validate_receipts(root),
        validate_residuals(root),
        validate_dependency_references(root),
        validate_duplicate_checkpoint_ids(root),
        verify_hash_manifest(root),
        check_markdown_links(root),
    ):
        errors.extend(check)
    if "TODO" in (root / "continuity/CURRENT_STATE.md").read_text(encoding="utf-8"):
        warnings.append("canonical state contains TODO marker")
    return {
        "status": "failed" if errors else "passed_with_warnings" if warnings else "passed",
        "errors": errors,
        "warnings": warnings,
        "release_blocked": bool(errors),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--release", action="store_true", help="return nonzero on any release-blocking defect")
    parser.add_argument("--json", action="store_true", help="emit structured JSON")
    args = parser.parse_args()
    result = validate(args.root.resolve())
    if args.json:
        print(json.dumps(result, indent=2))
    else:
        print(f"Continuity validation: {result['status']}")
        for warning in result["warnings"]:
            print(f"WARNING: {warning}")
        for error in result["errors"]:
            print(f"ERROR: {error}", file=sys.stderr)
    return 1 if args.release and result["release_blocked"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
