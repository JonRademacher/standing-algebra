#!/usr/bin/env python3
"""Check internal Markdown links in product documentation."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from continuity_lib import ROOT, check_markdown_links


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    args = parser.parse_args()
    errors = check_markdown_links(args.root.resolve())
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print("Markdown links: passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
