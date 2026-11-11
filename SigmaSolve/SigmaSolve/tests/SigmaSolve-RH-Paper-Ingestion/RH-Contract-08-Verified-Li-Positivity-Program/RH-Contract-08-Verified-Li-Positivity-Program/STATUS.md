# Contract 08 status

## Current maturity

- 08A formal baseline: `READY_TO_REPRODUCE`
- 08B positivity laboratory: `IMPLEMENTED_SCAFFOLD`
- 08C adversarial ablations: `IMPLEMENTED_AND_SMOKE_TESTED`
- 08D bounded positivity: `RESEARCH_CONTRACT_DEFINED`
- Universal positivity: `OPEN`
- Riemann Hypothesis: `OPEN`

## Canonical target

```text
RiemannHypothesis ↔ ∀ n, 0 ≤ liCoeff n
```

The exact Lean theorem name and coefficient normalization must be taken from the pinned formal baseline after reproduction. Repository descriptions are not proof receipts.

## Reopening/advance conditions

Advance this contract only when at least one occurs:

1. 08A cleanly reproduces the Li-criterion equivalence and normalization theorem.
2. a candidate in 08B passes identity and independence gates.
3. 08C produces a counterexample eliminating a candidate.
4. 08D proves a new bounded positivity theorem with explicit constants.
