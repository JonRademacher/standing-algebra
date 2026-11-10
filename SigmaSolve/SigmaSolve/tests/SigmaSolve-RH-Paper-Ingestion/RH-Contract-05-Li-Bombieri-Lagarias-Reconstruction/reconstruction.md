# Exact detector reconstruction

Let R be a multiset of complex numbers rho satisfying the Bombieri–Lagarias hypotheses:

1. `1` is not in R;
2. the convergence condition

\[
\sum_{\rho\in R}\frac{1+|\operatorname{Re}\rho|}{(1+|\rho|)^2}<\infty
\]

holds, with the paper's star/symmetric limiting convention for the relevant sums.

For positive integers n, define the transformed sums in the orientation used by the general half-plane theorem:

\[
B_n(R)=\sum_{\rho\in R}
\left[1-\left(1-\frac1\rho\right)^{-n}\right].
\]

Bombieri–Lagarias Theorem 1 makes the following equivalent:

- every rho in R satisfies Re(rho) <= 1/2;
- B_n(R) >= 0 for every n>=1;
- B_n(R) has the stated subexponential lower bound.

If the half-plane condition fails, there is a maximal transformed modulus `1+t>1`, attained by finitely many exceptional elements. All other transformed terms have modulus at most `1+t-delta` for a fixed delta>0. Simultaneous Diophantine approximation produces infinitely many n for which the exceptional phases align, while the remaining terms are exponentially smaller up to a polynomial factor. Therefore B_n(R) is negative infinitely often and exponentially large in magnitude.

For a multiset invariant under conjugation and rho -> 1-rho with matching multiplicity, the half-plane criterion applied to R and its reflected realization yields the critical-line corollary. In the nontrivial zeta-zero realization, this is Li's criterion.

## Finite witness consequence

An off-critical-line zero therefore does not merely make negativity plausible. Under the theorem's exact multiset and convergence hypotheses, it implies:

\[
\exists n\ge1,\quad \lambda_n<0,
\]

indeed for infinitely many n. Each such n is a finite witness index.

## What is still required for formal verification

- bind the zeta-zero multiset and multiplicity to a formal library;
- prove the Bombieri–Lagarias summability hypothesis for that multiset;
- define star/symmetric convergence;
- transcribe the maximal-modulus and tail estimates;
- formalize simultaneous Diophantine approximation;
- establish exact agreement between the multiset sum and derivative-form Li coefficient;
- cleanly replay the result.
