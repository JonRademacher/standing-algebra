#!/usr/bin/env bash
set -euo pipefail

Z3_BIN="${Z3_BIN:-z3}"
MANIFEST="${1:-z3_manifest.txt}"

require_file() {
  [[ -f "$1" ]] || { echo "ERROR: Missing file: $1" >&2; exit 2; }
}

z3_status_lines() {
  "$Z3_BIN" "$1" 2>&1 | tr -d '\r' | grep -E '^(sat|unsat|unknown)$' || true
}

check_expect_all() {
  local expected="$1"
  local file="$2"

  require_file "$file"

  local lines
  lines="$(z3_status_lines "$file")"

  if [[ -z "$lines" ]]; then
    echo "FAIL: $file => no sat/unsat/unknown lines (parse error or no check-sat?)" >&2
    exit 1
  fi

  if echo "$lines" | grep -q '^unknown$'; then
    echo "FAIL: $file => unknown (expected $expected)" >&2
    exit 1
  fi

  if echo "$lines" | grep -vq "^${expected}\$"; then
    echo "FAIL: $file => expected all results '${expected}', got:" >&2
    echo "$lines" | sed 's/^/  - /' >&2
    exit 1
  fi

  local count
  count="$(echo "$lines" | wc -l | tr -d ' ')"
  echo "PASS: $file => ${expected} (${count} check-sat)"
}

echo "Z3 version:"
"$Z3_BIN" -version || true
echo

echo "Available SMT2 files under Z3 SMT-LIB:"
find "Z3 SMT-LIB" -maxdepth 1 -type f -name '*.smt2' -print || true


require_file "$MANIFEST"
echo "=== Running Z3 checks from manifest: $MANIFEST ==="

while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

  expected="$(awk '{print $1}' <<<"$line")"
  path="${line#*$expected}"
  path="${path#" "}"  # trim a single leading space

  if [[ "$expected" != "sat" && "$expected" != "unsat" ]]; then
    echo "ERROR: Bad expected value '$expected' in manifest line: $line" >&2
    exit 2
  fi

  check_expect_all "$expected" "$path"
done < "$MANIFEST"

echo
echo "All Z3 checks passed."
``
