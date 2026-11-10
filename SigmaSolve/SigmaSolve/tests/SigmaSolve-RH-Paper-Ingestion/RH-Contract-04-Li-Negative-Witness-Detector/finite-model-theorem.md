# Finite-model amplification theorem

Let \(Z=\{z_1,\dots,z_m\}\) be a finite conjugation-stable multiset and define

\[
L_n=\sum_{j=1}^m(1-z_j^n).
\]

Suppose \(R=\max_j|z_j|>1\), and let \(M=\{j:|z_j|=R\}\). If there exists an integer subsequence \(n_k\to\infty\) and \(\delta>0\) such that

\[
\operatorname{Re}\sum_{j\in M}\left(\frac{z_j}{R}\right)^{n_k}\ge\delta,
\]

then \(L_{n_k}<0\) for every sufficiently large \(k\).

## Proof

Write \(r=\max_{j\notin M}|z_j|<R\). Then

\[
\operatorname{Re}L_n
=m-R^n\operatorname{Re}\sum_{j\in M}(z_j/R)^n
-\operatorname{Re}\sum_{j\notin M}z_j^n.
\]

The last term has absolute value at most \((m-|M|)r^n\). Along the assumed subsequence,

\[
\operatorname{Re}L_{n_k}
\le m-\delta R^{n_k}+(m-|M|)r^{n_k}.
\]

Since \(r/R<1\), the negative \(-\delta R^{n_k}\) term dominates. Hence \(L_{n_k}<0\) eventually.

## Scope

This proves a finite-model detector under an explicit phase-recurrence condition. It does not by itself prove the zeta detector because the zeta zero multiset is infinite and its coefficient sum requires a symmetric limit.
