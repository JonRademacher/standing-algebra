#!/usr/bin/env python3
"""Generate or verify the SHA-256 manifest for the managed repository tree."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from continuity_lib import ROOT, verify_hash_manifest, write_hash_manifest


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--write", action="store_true", help="regenerate manifests/SHA256SUMS")
    args = parser.parse_args()
    root = args.root.resolve()
    if args.write:
        lines = write_hash_manifest(root)
        print(f"SHA-256 manifest written: {len(lines)} files")
        return 0
    errors = verify_hash_manifest(root)
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print("SHA-256 manifest: passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
