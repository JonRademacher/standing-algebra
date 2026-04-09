#!/usr/bin/env bash
set -euo pipefail

Z3_BIN="${Z3_BIN:-z3}"

SCAN_DIRS=(
  "Z3 SMT-LIB"
  "Collapse_Demonstrations"
)

echo "Z3 version:"
"$Z3_BIN" -version || true
echo

# Extract all sat/unsat/unknown lines
z3_status_lines() {
  local f="$1"
  "$Z3_BIN" "$f" 2>&1 | tr -d '\r' | grep -E '^(sat|unsat|unknown)$' || true
}

# Determine expected result based on filename
expected_result() {
  local f="$1"
  case "$(basename "$f")" in
    Collapse_System.smt2)
      echo "unsat"
      ;;
    *)
      echo "sat"
      ;;
  esac
}

check_file() {
  local f="$1"
  local expected
  expected="$(expected_result "$f")"

  local lines
  lines="$(z3_status_lines "$f")"

  if [[ -z "$lines" ]]; then
    echo "ERROR  : $f -> no sat/unsat/unknown output (parse error or missing (check-sat))"
    return 2
  fi

  if echo "$lines" | grep -q '^unknown$'; then
    echo "UNKNOWN: $f ->"
    echo "$lines" | sed 's/^/  /'
    return 1
  fi

  # Require ALL check-sat results to match expected
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

scan_dir() {
  local dir="$1"
  [[ -d "$dir" ]] || { echo "WARN   : Skipping missing dir: $dir"; return 0; }

  echo "=== Scanning: $dir ==="

  local rc_any=0
  while IFS= read -r -d '' f; do
    if ! check_file "$f"; then
      rc_any=1
    fi
  done < <(find "$dir" -type f -name '*.smt2' -print0 | sort -z)

  echo
  return "$rc_any"
}

overall_rc=0
for d in "${SCAN_DIRS[@]}"; do
  if ! scan_dir "$d"; then
    overall_rc=1
  fi
done

if [[ "$overall_rc" -eq 0 ]]; then
  echo "Z3 CI passed: all files matched expected SAT/UNSAT behavior."
else
  echo "Z3 CI failed: at least one file did not match expected behavior."
fi

exit "$overall_rc"
