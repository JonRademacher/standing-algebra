#!/usr/bin/env bash
set -euo pipefail

Z3_BIN="${Z3_BIN:-z3}"
Z3_TIMEOUT=5   # seconds — prevents CI hangs

SCAN_DIRS=(
  "Z3 SMT-LIB"
  "Collapse_Demonstrations"
)

echo "Z3 version:"
"$Z3_BIN" -version || true
echo

# ------------------------------------------------------------
# Guard: fail fast on HTML entities (common silent breakage)
# ------------------------------------------------------------
if grep -R '&gt;\|&lt;\|=&gt;' -n \
    "Z3 SMT-LIB" \
    "Collapse_Demonstrations" \
    z3_check.sh; then
  echo
  echo "ERROR: HTML entities found. Use real SMT-LIB operators: >= <= =>"
  exit 1
fi

# ------------------------------------------------------------
# Extract all sat / unsat / unknown lines from Z3 output
# (supports multiple check-sat per file)
# ------------------------------------------------------------
z3_status_lines() {
  local f="$1"
  "$Z3_BIN" -T:${Z3_TIMEOUT} "$f" 2>&1 \
    | tr -d '\r' \
    | grep -E '^(sat|unsat|unknown)$' || true
}

# ------------------------------------------------------------
# Expected result policy (THIS is the key logic)
# ------------------------------------------------------------
expected_result() {
  case "$(basename "$1")" in
    Collapse_System.smt2)
      echo "sat"
      ;;
    Collapse_With_StandingAlgebra.smt2)
      echo "unsat"
      ;;
    Goodhart_System.smt2)
      echo "sat"
      ;;
    Goodhart_With_StandingAlgebra.smt2)
      echo "unsat"
      ;;
    *)
      # Everything else (core, basics, examples) must be SAT
      echo "sat"
      ;;
  esac
}

# ------------------------------------------------------------
# Check a single SMT2 file
# ------------------------------------------------------------
check_file() {
  local f="$1"
  local expected
  expected="$(expected_result "$f")"

  local lines
  lines="$(z3_status_lines "$f")"

  if [[ -z "$lines" ]]; then
    echo "ERROR  : $f -> no sat/unsat/unknown output (parse error or missing (check-sat))"
    return 1
  fi

  if echo "$lines" | grep -q '^unknown$'; then
    echo "FAIL   : $f -> Z3 returned unknown"
    echo "$lines" | sed 's/^/  /'
    return 1
  fi

  if echo "$lines" | grep -vq "^${expected}\$"; then
    echo "FAIL   : $f -> expected ${expected}, got:"
    echo "$lines" | sed 's/^/  /'
    return 1
  fi

  local count
  count="$(echo "$lines" | wc -l | tr -d ' ')"
  echo "OK     : $f -> ${expected} (check-sat count: $count)"
  return 0
}

# ------------------------------------------------------------
# Scan directories
# ------------------------------------------------------------
overall_rc=0

for dir in "${SCAN_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "WARN   : Skipping missing directory: $dir"
    continue
  fi

  echo "=== Scanning: $dir ==="

  while IFS= read -r -d '' f; do
    if ! check_file "$f"; then
      overall_rc=1
    fi
  done < <(find "$dir" -type f -name '*.smt2' -print0 | sort -z)

  echo
done

# ------------------------------------------------------------
# Final status
# ------------------------------------------------------------
if [[ "$overall_rc" -eq 0 ]]; then
  echo "Z3 CI passed: Standing Algebra demonstrably eliminates collapse."
else
  echo "Z3 CI failed: at least one file did not match expected behavior."
fi

exit "$overall_rc"
