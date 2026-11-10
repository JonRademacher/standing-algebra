"""Verify a guarded agent run and its audit trail.

    python Standing_Guard_Audit_Demo.py

The scenario and the numbers live in ``standing_guard/demo.py`` so the same
example runs from an installed package with ``python -m standing_guard demo``.
"""

from __future__ import annotations

import tempfile
from pathlib import Path

from standing_guard.demo import run


def main() -> int:
    with tempfile.TemporaryDirectory() as directory:
        summary = run(audit_path=Path(directory) / "agent-run.jsonl")
    flagged = summary["counters"]["flagged"]
    print("")
    print(f"This run would have been reported as {flagged} rejected win(s) rather than a clean pass.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
