# RH Contract 03 — Finite Negative Witness / Independent Positivity Barrier

This is an **additional child contract**, not an upgrade to Contract 02.

- Contract 01 ingests and evaluates the papers.
- Contract 02 constructs the count geometry N0(T) <= N(T) and the exact RH equivalence frontier.
- Contract 03 attempts a contradiction bridge:

```text
off-critical-line jump
    -> finite negative witness
    -> independent theorem forbids every negative witness
    -> contradiction
    -> no off-critical-line jump
    -> RH
```

The preferred witness family is the Keiper-Li coefficient sequence. The contract also preserves a Weil-positive test-function realization as a secondary survivor.

The contract is complete only if the negativity detector and positivity barrier are both proved, formally bound to the same witness definition, and the positivity proof is independent of RH or an equivalent assumption.
