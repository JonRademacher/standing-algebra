# Paper-level derivation before formal binding

Let Z(T) be the finite multiset of nontrivial zeros rho with 0 < Im(rho) <= T, counted with multiplicity. Let Z0(T) be the submultiset satisfying Re(rho)=1/2.

Define N(T)=card Z(T) and N0(T)=card Z0(T).

## G2

Because Z0(T) is a submultiset of Z(T), N0(T) <= N(T).

## G3

Assume N0(T)=N(T). If an element of Z(T) were absent from Z0(T), the proper submultiset would have strictly smaller finite cardinality, contradicting equality. Therefore every zero represented by Z(T) lies on the critical line.

## G4

Assume RH. Every nontrivial zero lies on the critical line. Therefore for every T, the filtered multisets Z0(T) and Z(T) coincide, hence N0(T)=N(T).

## G5

Assume for every T>0 that N0(T)=N(T). Let rho be any nontrivial zero. Choose T > Im(rho) (or use |Im(rho)| together with conjugation conventions if the formal RH predicate ranges over both signs). G3 at that T forces Re(rho)=1/2. Thus RH follows, provided the formal zero domain and sign convention cover every nontrivial zero.

## Remaining mathematical/formal residuals

The abstract finite-multiset argument is elementary. The hard formal work is constructing a finite carrier of analytically continued zeta zeros through a bounded height with multiplicity and binding that carrier to Mathlib's RH predicate. This contract does not assume that Mathlib already provides exactly this object.
