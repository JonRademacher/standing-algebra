# T5 audit — limit to Li coefficients

Theorem 1.2 is stronger than the earlier audit summary suggested. It does not merely assert the existence of approximants. It states that for every positive integer \(n\), there are real smooth functions \(g_{n,\varepsilon}\) with controlled support, defines

\[
h_{n,\varepsilon}(x)
=
\int_0^\infty g_{n,\varepsilon}(xy)g_{n,\varepsilon}(y)\,dy,
\]

proves

\[
\widehat h_{n,\varepsilon}(0)
=
\widehat h_{n,\varepsilon}(1)
=0,
\]

and claims

\[
\lim_{\varepsilon\to0^+}\Delta(h_{n,\varepsilon})
=2\lambda_n.
\]

The proof builds the functions through preceding lemmas and explicitly invokes the symmetric pairing of \(\rho\) and \(1-\rho\).

## Useful identity check

The displayed identity

\[
(1-A)(1-B)=(1-A)+(1-B)
\]

is valid here because

\[
A=\left(1-\frac1s\right)^n,
\qquad
B=\left(1-\frac1{1-s}\right)^n,
\qquad AB=1.
\]

So that specific step is not an algebraic error.

## Remaining audit burden

The entire construction must still be independently reproduced, especially:

- the approximation lemma for \(\ell_{n,\varepsilon}\);
- construction and support of \(g_{n,\varepsilon}\);
- the Mellin transform calculations;
- symmetric convergence of \(\Delta(h)\);
- the \(\varepsilon\)-limit over all zeros;
- agreement with the standard Li normalization.

T5 is therefore upgraded from "bare limit gap" to "substantial explicit proof present, independent reconstruction pending."
