import SigmaR.StandingAlgebra_RegimeStacked
import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Operations.ResolutionMethodDistinctness_Op

namespace SigmaR

/-- An operation satisfies the non-retributive proportionality gate at every state. -/
def NRPP_Satisfied (F : Operation) : Prop :=
  ∀ s : State, NRPP_Fit F s

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
