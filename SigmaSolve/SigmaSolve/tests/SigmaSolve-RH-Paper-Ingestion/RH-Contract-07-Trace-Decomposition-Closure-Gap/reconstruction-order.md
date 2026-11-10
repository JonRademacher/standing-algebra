# Reconstruction order

## Phase 1 — T1 definitions

Freeze every object before proving positivity:

- local and restricted adele spaces;
- ideles and the subgroup used in the quotient;
- quotient Hilbert spaces;
- additive and multiplicative Haar measures;
- Fourier transform conventions;
- maps E_S and F_S;
- projections P_Lambda and S_Lambda;
- Q_Lambda and its orthogonal complement;
- convolution operator V_S(h);
- the complete operator T_h.

## Phase 2 — T2 trace legitimacy

For every trace expression, record:

- operator domain and codomain;
- boundedness;
- self-adjointness if claimed;
- Hilbert-Schmidt or trace-class witness;
- kernel diagonal theorem;
- chosen orthonormal basis independence.

## Phase 3 — T3 infinite-repeat reconstruction

Translate each repeated-summand step into an explicit lemma:

```text
sum_{gamma in Gamma} c = L
```

with:

- Gamma proved infinite;
- c independent of gamma;
- the series defined in an ordinary absolutely convergent sense;
- L finite.

Only then infer c=0.

## Phase 4 — T4 projected-trace positivity

Prove:

```text
tr(VS(h) S_Lambda)
  = tr(S_Lambda VS(h) S_Lambda)
  + tr((1-S_Lambda) VS(h) S_Lambda)
```

and separately:

- first trace is nonnegative;
- second trace is zero.

## Phase 5 — T5 Li limit

Verify the test functions, Mellin boundary values, explicit formula, grouped zero sum, and epsilon limit. Do not mix this phase with operator positivity.
