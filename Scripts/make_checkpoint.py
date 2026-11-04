#!/usr/bin/env python3
"""Initialize a checkpoint only from explicit source revisions and receipts."""

from __future__ import annotations

import argparse
import json
import re
from datetime import datetime, timezone
from pathlib import Path

from continuity_lib import (
    ROOT,
    git_status_paths,
    git_value,
    load_json_yaml,
    sha256_file,
    write_hash_manifest,
)


def make_checkpoint(
    root: Path,
    checkpoint_id: str | None = None,
    canonical: bool = False,
) -> dict[str, object]:
    revisions_path = root / "manifests/SOURCE_REPOSITORIES.json"
    receipts_path = root / "manifests/VALIDATION_RECEIPTS.json"
    corpus_path = root / "manifests/CORPUS_MANIFEST.yaml"
    revisions = json.loads(revisions_path.read_text(encoding="utf-8"))
    receipts = json.loads(receipts_path.read_text(encoding="utf-8"))
    if canonical:
        incomplete = [
            check
            for check, receipt_id in receipts["required_receipts"].items()
            if receipts["receipts"].get(receipt_id, {}).get("status") != "passed"
        ]
        if incomplete:
            raise ValueError(f"cannot initialize canonical checkpoint; required checks not passed: {incomplete}")
    corpus = load_json_yaml(corpus_path)
    for source in corpus["sources"]:
        if source.get("path"):
            source["sha256"] = sha256_file(root / source["path"])
    with corpus_path.open("w", encoding="utf-8", newline="\n") as stream:
        stream.write(json.dumps(corpus, indent=2, ensure_ascii=False) + "\n")
    head = git_value(root, "rev-parse", "HEAD") or "unavailable"
    branch = git_value(root, "branch", "--show-current") or "unavailable"
    dirty_paths = git_status_paths(root)
    if dirty_paths is None:
        dirty_paths = ["git-status-unavailable"]
    stamp = datetime.now(timezone.utc).isoformat(timespec="seconds").replace("+00:00", "Z")
    if checkpoint_id is None:
        current_state = (root / "continuity/CURRENT_STATE.md").read_text(encoding="utf-8")
        match = re.search(r"Checkpoint ID:\*{0,2}\s*`?([^`\s]+)", current_state)
        checkpoint_id = match.group(1) if match else f"UCK-{datetime.now(timezone.utc):%Y-%m-%d}-001"

    sources = revisions["repositories"]
    repositories: dict[str, object] = {}
    for key in ("standing_algebra", "icg", "kernel"):
        source = sources[key]
        repositories[key] = {
            "url": source.get("url"),
            "commit": head if key == "kernel" else source.get("commit"),
            "branch": branch if key == "kernel" else source.get("branch"),
            "status": source["status"],
            "path": source.get("path"),
            "identity_note": source.get("identity_note"),
        }

    validation = {}
    for check, receipt_id in receipts["required_receipts"].items():
        entry = receipts["receipts"].get(receipt_id)
        validation[check] = {
            "status": entry["status"] if entry else "pending",
            "receipt_id": receipt_id,
        }

    manifest: dict[str, object] = {
        "schema_version": 1,
        "checkpoint_id": checkpoint_id,
        "created_at": stamp,
        "checkpoint_status": "canonical_partial" if canonical else "initialized_candidate",
        "product": {
            "name": "Repository-backed continuity integration",
            "version": "0.1.0",
            "host_branch": branch,
            "host_head_at_generation": head,
            "worktree_dirty_paths": dirty_paths,
        },
        "repositories": repositories,
        "corpus_sources": [item["id"] for item in corpus["sources"]],
        "validation": validation,
        "residuals": [
            {"id": item["id"], "status": item["status"], "description": item["description"]}
            for item in _residuals(root)
        ],
        "supersedes": [],
        "rollback": {
            "instructions": "Revert only continuity integration paths in the completion report; preserve unrelated pre-existing user edits.",
            "prior_checkpoint": "Standing Algebra source baseline at cbc4211baf0993d643e55398addabf9588120f3f",
        },
        "hash_scope": "manifests/SHA256SUMS covers managed files except itself, this checkpoint manifest, and the known pre-existing user edit Collapse_Demonstrations/collapse.lean.",
    }
    target = root / "manifests/CURRENT_CHECKPOINT.yaml"
    with target.open("w", encoding="utf-8", newline="\n") as stream:
        stream.write(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n")
    write_hash_manifest(root)
    return manifest


def _residuals(root: Path) -> list[dict[str, str]]:
    path = root / "continuity/OPEN_RESIDUALS.md"
    entries: list[dict[str, str]] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.startswith("| R-"):
            continue
        fields = [part.strip() for part in line.strip("|").split("|")]
        if len(fields) >= 3:
            entries.append({"id": fields[0], "status": fields[1], "description": fields[2]})
    return entries


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--id")
    parser.add_argument(
        "--canonical",
        action="store_true",
        help="initialize a partial canonical checkpoint only after all required receipts pass",
    )
    args = parser.parse_args()
    try:
        manifest = make_checkpoint(args.root.resolve(), args.id, args.canonical)
    except ValueError as error:
        parser.error(str(error))
    print(json.dumps({
        "checkpoint_id": manifest["checkpoint_id"],
        "status": manifest["checkpoint_status"],
        "host_head_at_generation": manifest["product"]["host_head_at_generation"],
        "residual_count": len(manifest["residuals"]),
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
