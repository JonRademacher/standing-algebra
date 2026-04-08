#!/usr/bin/env bash
set -e

echo "Running Z3 collapse demonstrations..."

echo "Checking collapsing system (should be SAT)"
z3 Collapse_Demonstrations/Collapse_System.smt2 | grep sat

echo "Checking Standing Algebra system (should be UNSAT)"
z3 Collapse_Demonstrations/Collapse_With_StandingAlgebra.smt2 | grep unsat

echo "Collapse demonstration checks passed."
