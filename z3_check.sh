#!/usr/bin/env bash
set -euo pipefail

Z3_BIN="${Z3_BIN:-z3}"

# Folders to scan (quote because of spaces)
SCAN_DIRS=(
  "Z3 SMT-LIB"
  "Collapse_Demonstrations"
)

echo "Z3 version:"
"$Z3_BIN" -version || true
echo

# Extract all status lines that are exactly: sat|unsat|unknown
# This supports files that have multiple (check-sat) calls.
z3_status_lines() {
  local f="$1"
  "$Z3_BIN" "$f" 2>&1 | tr -d '\r' | grep -E '^(sat|unsat|unknown)$' || true
}

# Run Z3 on a file and print a concise report.
# Returns:
#   0 if sat/unsat only
#   1 if unknown appears
#   2 if no sat/unsat/unknown lines appear (parse error or missing check-sat)
check_file() {
  local f="$1"
  local lines
  lines="$(z3_status_lines "$f")"

  if [[ -z "$lines" ]]; then
    echo "ERROR  : $f -> no sat/unsat/unknown output (parse error or missing (check-sat))"
    return 2
  fi

  if echo "$lines" | grep -q '^unknown$'; then
    # Show all status lines so you can see if it's mixed
    echo "UNKNOWN: $f ->"
    echo "$lines" | sed 's/^/  /'
    return 1
  fi

  # If there are multiple (check-sat), show count and the unique statuses
  local count uniq
  count="$(echo "$lines" | wc -l | tr -d ' ')"
  uniq="$(echo "$lines" | sort -u | tr '\n' ' ' | sed 's/[[:space:]]*$//')"

  echo "OK     : $f -> $uniq (check-sat count: $count)"
  return 0
}

# Walk a directory and check all .smt2 files
scan_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    echo "WARN   : Directory not found, skipping: $dir"
    return 0
  fi

  echo "=== Scanning: $dir ==="

  local found=0
  local rc_any=0

  while IFS= read -r -d '' f; do
    found=1
    if ! check_file "$f"; then
      # Preserve the "worst" return code (2 > 1 > 0)
      local rc=$?
      if (( rc > rc_any )); then rc_any=$rc; fi
    fi
  done < <(find "$dir" -type f -name '*.smt2' -print0 | sort -z)

  if [[ "$found" -eq 0 ]]; then
    echo "WARN   : No .smt2 files found in: $dir"
  fi

  echo
  return "$rc_any"
}

# Main
overall_rc=0
for d in "${SCAN_DIRS[@]}"; do
  if ! scan_dir "$d"; then
    rc=$?
    if (( rc > overall_rc )); then overall_rc=$rc; fi
  fi
done

case "$overall_rc" in
  0) echo "All SMT-LIB files returned sat/unsat (no unknown, no parse failures).";;
  1) echo "Some SMT-LIB files returned unknown (CI failing by policy).";;
  2) echo "Some SMT-LIB files failed to produce sat/unsat/unknown (parse error or missing check-sat).";;
esac

exit "$overall_rc"
``
