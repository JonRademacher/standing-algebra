# Fundamental-domain binding

Connes's S-local construction lets

\[
O_S^*=\{q\in k^*:|q_v|=1\text{ for }v\notin S\}
\]

act on the S-ideles `J_S`. The source states that `O_S^*` is cocompact in the norm-one component and normalizes multiplicative Haar measure by choosing a fundamental domain `D` for this action.

The Hilbert norm is then defined by

\[
\|f\|^2
=
\int_D
\left|
\sum_{q\in O_S^*}f(qx)
\right|^2
|x|\,d^*x,
\]

or equivalently as an integral on `C_S`.

This establishes the correct quotient-level carrier for the orbit sum and supplies the source architecture needed by C07B's unitary-inverse repair.

## Consequence for T3

The proof no longer lacks a fundamental-domain architecture in principle. However, Li's exact decomposition

\[
J_S=\bigsqcup_{\xi\in O_S^*}\xi I_S
\]

must still be tied to a measurable representative `I_S=D` from the source and every integrand in equations (4.11)-(4.14) must be shown compatible with that quotient realization.
