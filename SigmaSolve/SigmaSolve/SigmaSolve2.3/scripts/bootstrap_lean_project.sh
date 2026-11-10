#!/usr/bin/env bash
set -euo pipefail
ROOT=${1:-sigmasolve-mathlib}
mkdir -p "$ROOT" && cd "$ROOT"
if ! command -v lake >/dev/null 2>&1; then echo "lake is required; install elan or use Docker" >&2; exit 2; fi
lake +stable init "$ROOT" math
lake update
lake exe cache get
printf 'Initialized Lean/Mathlib project: %s
' "$PWD"
