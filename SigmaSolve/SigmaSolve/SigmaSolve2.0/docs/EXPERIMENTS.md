# Experimental protocol

## Primary hypothesis

An unchanged model with ΣSolve attains a higher verified solve rate than the same model under equalized ordinary prompting or retry conditions.

## Conditions

- C0: direct model response, no verifier feedback.
- C1: one response plus raw Lean diagnostics.
- C2: sequential retry loop with the same total model-call budget.
- C3: ΣSolve candidate landscape, typed feedback, repair, survivor preservation, and clean replay.

## Controls

Use identical problem splits, model version, temperature policy, call budget, verifier timeout, hardware class, and wall-clock ceiling. Freeze prompts and source files before evaluation. Report all failed, timeout, and malformed runs.

## Metrics

- kernel-verified solve rate;
- false-success rate;
- model calls and verifier calls;
- cost and wall time per verified solution;
- unique problems solved per condition;
- verified intermediate lemmas;
- cross-problem reuse of generated lemmas;
- cross-model transfer;
- component ablations.

## Claim maturity

A local benchmark is internal evidence. Reproduction on a clean machine is computational reproducibility. Reproduction by an independent group is independent reproduction. None alone establishes mathematical or architectural originality.
