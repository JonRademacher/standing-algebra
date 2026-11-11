# Trace-theorem instantiation audit

## What Connes proves

For compactly supported Schwartz `h` on `C_S`, Connes defines infrared and ultraviolet cutoffs and proves an asymptotic S-local trace formula for

\[
R_\Lambda U(h),
\qquad
R_\Lambda=\widehat P_\Lambda P_\Lambda.
\]

The source also gives the quotient kernel trace shape

\[
\operatorname{Tr}(T)
=
\sum_{q\in O_S^*}
\int_D k(x,qx)\,dx
\]

for a suitable invariant integral-kernel operator on the quotient.

## Why this is not yet Li's Theorem 1.1

Li's candidate uses an operator denoted `T_h` built through `E_S`, Fourier transforms, and projections, and claims an exact trace identity

\[
\operatorname{tr}(T_h)
=
\Delta(h)-\widehat h(0)-\widehat h(1).
\]

The Connes theorem retrieved here concerns a cutoff family and an asymptotic formula. Before importing it into Li's argument, one must prove:

1. exact equality or a proved limiting relationship between Li's `T_h` and the source cutoff operator;
2. compatibility of all Fourier conventions and basic characters;
3. that Li's special `h_{n,\varepsilon}` satisfy the required Schwartz/compact-support hypotheses;
4. that every compressed and cross operator remains trace class;
5. that any limit in `Lambda` commutes with the subsequent `epsilon` limit used for Li coefficients.

## Audit determination

The source validates the general S-local trace-formula environment, but it does not by itself validate Li's exact trace theorem. Treating the two operators as identical would be an inadmissible transfer-by-notation.
