# Conditional inverse-repair theorem

Let `H0` be a pre-Hilbert space and `K` a Hilbert space. Let

\[
E_0:H_0\to K
\]

satisfy

\[
\langle f,g\rangle_{H_0}
=
\langle E_0f,E_0g\rangle_K.
\]

Let `H` be the Hilbert completion after quotienting zero-norm vectors if necessary.

Then `E_0` descends uniquely to an isometric linear map

\[
E:H\to K.
\]

If the range of `E_0` is dense in `K`, then the range of `E` is both dense and closed. Therefore

\[
\operatorname{Ran}E=K,
\]

so `E` is unitary and possesses a unique bounded inverse

\[
E^{-1}:K\to H.
\]

## Application to the candidate

The candidate defines the `L2(X_S)` inner product by the `L2(C_S)` inner product of `E_S(f)` and `E_S(g)`, and cites an external proposition for dense range of `E_S`. Under those two statements, the Hilbert completion supplies the canonical inverse actually required by the later operator expressions.

Thus the displayed set

\[
E_S^{-1}(F)=\{f(\xi x):\xi\in O_S^*\}
\]

should not be used as the operator definition. The correct operator object is the inverse of the induced unitary extension. The orbit notation can at most describe representative ambiguity before passage to the completed quotient.

## Status

This is a functional-analytic repair theorem proved independently here. It does not prove that the candidate's cited `L2(X_S)` construction satisfies every required hypothesis. That source binding remains external-unverified.
