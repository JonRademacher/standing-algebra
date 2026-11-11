# RH Contract 08 — Verified Li-Positivity Program

Contract 08 is a **new execution contract**. Contract 07 audited a specific trace-operator proof candidate and reached a certified reopening boundary. Contract 08 creates an independent, executable research surface around the exact missing theorem:

\[
\forall n\ge1,\qquad \lambda_n\ge0.
\]

## Contract layout

```text
RH-Contract-08-Verified-Li-Positivity-Program/
├── 08A-Lean-Baseline/
├── 08B-Positivity-Candidate-Lab/
├── 08C-Adversarial-Ablations/
├── 08D-Bounded-Positivity/
├── candidates/
├── counterexamples/
├── benchmarks/
├── scripts/
├── tests/
├── receipts/
├── STATUS.md
└── MANIFEST.sha256
```

## Terminal state at creation

```text
Contract created: yes
Formal Li baseline reproduced locally: no
Universal Li positivity proved: no
RH proved: no
```

The package is executable without external APIs for schema validation, dependency-cycle checks, finite-dimensional ablations, candidate registration, and receipt generation. Lean and external repositories remain environment-dependent.
