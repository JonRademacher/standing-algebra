#!/usr/bin/env bash
set -e

DIR="SigmaR/Valuation/Measures/Independence"

echo "🔍 Checking Independence invariants in $DIR"

# Forbidden constructs (semantic violations)
grep -R "≠" "$DIR" && echo "❌ Forbidden: ≠" && exit 1
grep -R "↔" "$DIR" && echo "❌ Forbidden: ↔" && exit 1
grep -R "> 0" "$DIR" && echo "❌ Forbidden: > 0" && exit 1
grep -R "= 0" "$DIR" && echo "❌ Forbidden: = 0" && exit 1
grep -R "if .* then .* else .*" "$DIR" && echo "❌ Forbidden: if-then-else encoding" && exit 1

echo "✅ Independence checks passed"
