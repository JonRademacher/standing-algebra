import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level predicate:

`F` represents a compromise operation
where agents accept bounded concessions.
-/
constant CompromiseOp : Operation → Prop

/--
Operations-level invariant (Compromise):

Compromise must preserve standing and
respect non-reciprocity prevention.
-/
axiom CompromiseInvariant :
  ∀ (F : Operation),
    CompromiseOp F →
    Admissible F ∧ StandingPreserved F ∧ NRPP_Satisfied F

/--
Derived theorem:

Compromise does not create domination.
-/
theorem CompromiseNonDominating
  (F : Operation)
  (hC : CompromiseOp F) :
  Admissible F ∧ StandingPreserved F ∧ NRPP_Satisfied F :=
by
  exact CompromiseInvariant F hC

end SigmaR
