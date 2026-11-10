"""Command line entry point: ``python -m standing_guard``.

Subcommands:

``demo``   run the worked agent-evaluation example
``audit``  verify a hash-chained log and summarize the verdicts recorded in it

``audit`` is meant for CI: it exits 1 if the log was altered after the fact and
2 if the guard flagged drift that was never cleared, so a pipeline can fail on
a gamed result instead of shipping it.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Sequence

from .audit import read_log, verify_log
from .demo import run as run_demo


def _summary(path: Path) -> dict:
    entries = read_log(path)
    verdicts = [e["record"] for e in entries if e.get("record", {}).get("kind") == "verdict"]
    flagged = [v for v in verdicts if not v.get("accepted")]
    observations = [e["record"] for e in entries if e.get("record", {}).get("kind") == "observation"]
    proxy = verdicts[0]["evidence"]["proxy"] if verdicts else None
    standing = verdicts[0]["evidence"]["standing"] if verdicts else None
    return {
        "entries": len(entries),
        "observations": len(observations),
        "verdicts": len(verdicts),
        "accepted": len(verdicts) - len(flagged),
        "flagged": len(flagged),
        "proxy": proxy,
        "standing": standing,
        "first_flag": flagged[0] if flagged else None,
    }


def audit_command(path: Path, as_json: bool) -> int:
    chain = verify_log(path)
    if not path.is_file():
        print(f"no such log: {path}", file=sys.stderr)
        return 1
    summary = _summary(path)
    if as_json:
        print(json.dumps({"chain": chain, "summary": summary}, indent=2))
    else:
        print(f"Log {path}: {chain['reason']}")
        print(
            f"Entries: {summary['entries']}  observations: {summary['observations']}  "
            f"verdicts: {summary['verdicts']}  accepted: {summary['accepted']}  "
            f"flagged: {summary['flagged']}"
        )
        if summary["proxy"]:
            print(f"Watched: {summary['proxy']} against {summary['standing']}")
        flag = summary["first_flag"]
        if flag:
            print(
                f"First flagged trial {flag['trial']}: proxy {flag['proxy_change']:+.2f}, "
                f"standing {flag['standing_change']:+.2f}"
            )
    if not chain["ok"]:
        return 1
    return 2 if summary["flagged"] else 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="standing_guard",
        description="Guard an optimised proxy against degrading its standing signal.",
    )
    sub = parser.add_subparsers(dest="command")
    audit = sub.add_parser("audit", help="verify an audit log and summarize its verdicts")
    audit.add_argument("path", type=Path)
    audit.add_argument("--json", action="store_true", help="emit machine-readable output")
    sub.add_parser("demo", help="run the worked agent-evaluation example")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(list(argv) if argv is not None else None)
    if args.command == "demo":
        run_demo()
        return 0
    if args.command == "audit":
        return audit_command(args.path, args.json)
    parser.print_help()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
