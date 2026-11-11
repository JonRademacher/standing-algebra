# T4 audit — projected trace positivity

The candidate does not make the invalid inference

\[
V_S(h)\ge0\Longrightarrow V_S(h)S_\Lambda\ge0.
\]

Instead, for an orthonormal basis \(F_i\) of the relevant subspace, the paper writes

\[
\operatorname{tr}(T_h)
=
\sum_i\langle V_S(h)S_\Lambda F_i,S_\Lambda F_i\rangle
+
\operatorname{tr}((1-S_\Lambda)T_h).
\]

The first term is nonnegative if Lemma 5.1 is correct. The second is evaluated by an integral-kernel formula and then claimed zero through a second infinite-identical-summand argument.

## Findings

- The decomposition correctly identifies the cross term rather than silently discarding it.
- The local Gram-form calculation for \(V_S(h)\) is structurally positive because it is an integral of a transform times its complex conjugate for real \(g\).
- The proof of Theorem 1.4 still depends on trace class, trace cyclicity, convergence, and the exact (5.8) to (5.10) transformations.

## Status

T4 survives conditionally. It cannot be promoted until all cross-operator traces and convergence claims are reconstructed independently.
