# Structural checks

## S-unit infinitude

For the finite set S used in the manuscript, S contains the real place and all primes up to a large positive bound. Hence at least one finite prime p lies in S. Every power p^k is a rational S-unit, so O_S^* is infinite. This prerequisite survives.

## Norm invariance

For a rational S-unit xi, the product formula gives |xi|_S=1 when all places outside S have local absolute value one. Thus the cutoffs |xi v|<1 and |v|<1 agree, and additive Haar measure scales by |xi|_S=1. This supports the changes v->xi v and u->u xi, assuming the selected Haar normalizations match the product formula.

## Infinite identical-summand lemma

If an absolutely summable family indexed by an infinite set has identical scalar value c at each index, then c=0. T3's final inference is valid once the antecedents are established.

## Fundamental domain

A countable discrete group acting measurably on J_S can admit a measurable fundamental domain, but the candidate's phrase "for any disjoint decomposition" is not itself a construction. Contract closure needs one explicit measurable I_S and proof that the translate union is complete modulo null sets.

## Material type issue: E_S inverse

The candidate writes

```text
E_S^{-1}(F) = { f(xi x) : xi in O_S^* }
```

which is a set/orbit of representatives, not a single vector. Later formulas compose E_S^{-1} with Fourier transforms, projections, and bounded operators as if E_S^{-1} were a single-valued linear isometry. The argument may be repairable if E_S descends to a unitary isomorphism from a quotient/completion and E_S^{-1} denotes that induced inverse, but that theorem must be stated and its hypotheses checked. Until then, the core operator products are not formally well-typed.
