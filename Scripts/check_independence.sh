#!/usr/bin/env bash
set -e

DIR="SigmaR/Valuation/Measures/Independence"

echo "🔍 Checking Independence invariants in $DIR"

# Files that are allowed to contain forbidden syntax
EXCLUDE_FILES="CollapseDemo.lean|IndependenceContract.lean"

# Helper: scan only non-comment lines, excluding allowed files
scan() {
  grep -R "$1" "$DIR" \
    | grep -vE "$EXCLUDE_FILES" \
    | grep -vE '^\s*--' \
    | grep -vE '^\s*/-' \
    | grep -vE '^\s*\*'
}

# Forbidden constructs (semantic violations)

scan "≠" && echo "❌ Forbidden: ≠ used in axioms" && exit 1
scan "↔" && echo "❌ Forbidden: ↔ used in axioms" && exit 1
scan "> 0" && echo "❌ Forbidden: numeric threshold (> 0)" && exit 1
scan "= 0" && echo "❌ Forbidden: numeric threshold (= 0)" && exit 1
scan "if .* then .* else .*" && echo "❌ Forbidden: predicate encoding via if-then-else" && exit 1

echo "✅ Independence checks passed"

