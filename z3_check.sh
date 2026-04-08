#!/usr/bin/env bash
set -e

echo "Running Z3 checks..."

for f in "Z3 SMT-LIB"/*.smt2; do
  echo "Checking $f"
  result=$(z3 "$f")
  echo "$result"

  if [[ "$result" != *"sat"* ]]; then
    echo "ERROR: $f did not return sat"
    exit 1
  fi
done

echo "All Z3 checks passed."
