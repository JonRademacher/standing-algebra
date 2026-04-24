import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level predicate:

`F` represents a negotiation operation if it adjusts
constraints symmetrically without reducing standing
or collapsing exit.
-/
constant NegotiationOp : Operation → Prop

/--
Operations-level invariant (Negotiation):

Negotiation preserves admissibility and exit
for all affected agents.
-/
axiom NegotiationInvariant :
  ∀ (F : Operation),
    NegotiationOp F →
    Admissible F ∧ ExitPreserved F

/--
Derived theorem:

Negotiation operations are non-coercive adjustments.
-/
theorem NegotiationAdmissible
  (F : Operation)
  (hN : NegotiationOp F) :
  Admissible F ∧ ExitPreserved F :=
by
  exact NegotiationInvariant F hN

end SigmaR
