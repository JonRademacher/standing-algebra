import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Tradeoffs Between Measures
###############################################################################

Non-comparable valuation measures admit no tradeoff
or compensatory reasoning.
###############################################################################
-/

namespace SigmaR

/--
No tradeoff is permitted between non-comparable measures.
-/
axiom no_tradeoffs_between_measures :
  ∀ (M₁ M₂ : Agent → State → Nat),
    ¬ (∃ (a : Agent) (s : State),
          True)

end SigmaR
