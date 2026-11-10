# Detector derivation

Define

\[
\xi(s)=\frac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)
\]

and, for \(n\ge1\),

\[
\lambda_n=\frac{1}{(n-1)!}\left.\frac{d^n}{ds^n}\left[s^{n-1}\log\xi(s)\right]\right|_{s=1}.
\]

The zero-sum representation is

\[
\lambda_n=\sum_\rho\left[1-\left(1-\frac1\rho\right)^n\right],
\]

with the sum interpreted using the required symmetric limiting convention.

Set

\[
z_\rho=1-\frac1\rho=\frac{\rho-1}{\rho}.
\]

Then

\[
|z_\rho|^2-1
=\frac{|\rho-1|^2-|\rho|^2}{|\rho|^2}
=\frac{1-2\operatorname{Re}(\rho)}{|\rho|^2}.
\]

Therefore:

\[
\operatorname{Re}(\rho)>\frac12
\quad\Longleftrightarrow\quad
|z_\rho|<1,
\]

and

\[
\operatorname{Re}(\rho)<\frac12
\quad\Longleftrightarrow\quad
|z_\rho|>1.
\]

Because the nontrivial zero set is symmetric under \(\rho\mapsto1-\rho\), any zero to the right of the critical line has a reflected zero to the left, whose transformed value has modulus greater than one. The Li/Bombieri-Lagarias detector theorem converts this half-plane failure into negativity of at least one finite coefficient.

## Critical nontrivial step

It is not sufficient to say that one term \(-z_\rho^n\) grows exponentially. One must control:

- conjugate and functional-equation partners;
- every zero with the same maximal transformed modulus;
- the remaining infinitely many zeros;
- the symmetric limiting convention;
- possible phase cancellation among maximal terms.

That global control is the content that must be reconstructed from the general multiset theorem, not replaced by an informal dominance assertion.
