#!/usr/bin/env python3
"""Build a bounded, provenance-bearing context bundle for a fresh session."""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from continuity_lib import ROOT, git_value, load_json_yaml

DEFAULT_MAX_CHARS = 24000
DEFAULT_INPUTS = (
    "continuity/CURRENT_STATE.md",
    "manifests/CURRENT_CHECKPOINT.yaml",
    "kernel/KERNEL_CURRENT.md",
    "kernel/INVARIANTS.md",
    "kernel/AUTHORITY_AND_PROVENANCE.md",
    "continuity/PROJECT_GRAPH.md",
    "continuity/DEPENDENCY_GRAPH.md",
    "continuity/ACTIVE_TRAJECTORIES.md",
    "continuity/CAPABILITY_TRAJECTORY_LEDGER.md",
    "continuity/OPEN_RESIDUALS.md",
    "continuity/MODEL_INADEQUACY_CONSTRUCTOR.md",
    "continuity/FUTURE_FORENSICS.md",
    "learning/FAILURE_SHAPES.md",
    "learning/DISCOVERY_SHAPES.md",
    "governance/VALIDATION_LADDER.md",
    "manifests/VALIDATION_RECEIPTS.json",
)


def build_bundle(root: Path, max_chars: int = DEFAULT_MAX_CHARS) -> str:
    if max_chars < 2000:
        raise ValueError("max_chars must be at least 2000")
    commit = git_value(root, "rev-parse", "HEAD") or "unavailable"
    branch = git_value(root, "branch", "--show-current") or "unavailable"
    worktree_status = git_value(root, "status", "--porcelain") or ""
    result = "\n".join([
        "# Bounded Continuity Context Bundle",
        "",
        f"- Generated from worktree: `{root}`",
        f"- Git branch: `{branch}`",
        f"- Git HEAD: `{commit}`",
        f"- Git worktree: `{'clean' if not worktree_status else 'contains uncommitted changes'}`",
        "- Epistemic status: reconstruction index; validate against live sources.",
        "- Framework boundary: Σᴿ and ICG are distinct peer frameworks.",
        "- No hidden model-state transfer, background autonomy, or behavioral identity is claimed.",
        "",
    ])
    for relative in DEFAULT_INPUTS:
        path = root / relative
        heading = f"## {relative}\n\n"
        if not path.is_file():
            section = heading + f"**Missing input:** `{relative}`\n\n"
            if len(result) + len(section) <= max_chars:
                result += section
                continue
            result = _append_truncation(result, relative, max_chars)
            break
        text = _render_input(root, relative, path)
        section = heading + text + "\n\n"
        if len(result) + len(section) <= max_chars:
            result += section
            continue
        available = max_chars - len(result) - len(heading)
        marker = f"\n[Truncated at bundle limit; full source: `{relative}`; remaining sources omitted.]\n"
        if available >= len(marker):
            result += heading + _truncate_at_boundary(text, available - len(marker)) + marker
        else:
            result = _append_truncation(result, relative, max_chars)
        break
    if len(result) > max_chars:
        raise ValueError(f"generated bundle exceeds limit: {len(result)} > {max_chars}")
    return result.rstrip() + "\n"


def _render_input(root: Path, relative: str, path: Path) -> str:
    if relative != "manifests/CURRENT_CHECKPOINT.yaml":
        return path.read_text(encoding="utf-8").strip()
    checkpoint = load_json_yaml(path)
    lines = [
        f"- ID: `{checkpoint.get('checkpoint_id', 'unknown')}`",
        f"- Status: `{checkpoint.get('checkpoint_status', 'unknown')}`",
        f"- Created: `{checkpoint.get('created_at', 'unknown')}`",
        f"- Host branch / HEAD: `{checkpoint.get('product', {}).get('host_branch', 'unknown')}` / "
        f"`{checkpoint.get('product', {}).get('host_head_at_generation', 'unknown')}`",
        "- Validation receipts:",
    ]
    for name, result in checkpoint.get("validation", {}).items():
        lines.append(f"  - {name}: {result.get('status', 'unknown')} ({result.get('receipt_id', 'no receipt')})")
    lines.append("- Open residuals:")
    for residual in checkpoint.get("residuals", []):
        lines.append(f"  - {residual['id']} ({residual['status']}): {residual['description']}")
    return "\n".join(lines)


def _truncate_at_boundary(text: str, budget: int) -> str:
    if len(text) <= budget:
        return text
    boundary = text.rfind("\n", 0, budget)
    if boundary < 0:
        boundary = text.rfind(" ", 0, budget)
    return text[: boundary if boundary > 0 else budget]


def _append_truncation(result: str, relative: str, max_chars: int) -> str:
    marker = f"\n[Bundle limit reached; remaining sources omitted. Full source: `{relative}`]\n"
    if len(result) + len(marker) <= max_chars:
        return result + marker
    return result[: max_chars - len(marker)] + marker


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--output", type=Path, default=Path("continuity/CONTEXT_BUNDLE.md"))
    parser.add_argument("--max-chars", type=int, default=DEFAULT_MAX_CHARS)
    args = parser.parse_args()
    root = args.root.resolve()
    output = args.output if args.output.is_absolute() else root / args.output
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", encoding="utf-8", newline="\n") as stream:
        stream.write(build_bundle(root, args.max_chars))
    print(json.dumps({"output": output.relative_to(root).as_posix(), "max_chars": args.max_chars}))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
