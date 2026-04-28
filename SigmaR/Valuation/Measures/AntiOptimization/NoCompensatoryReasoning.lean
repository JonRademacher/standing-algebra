import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Compensatory Reasoning
###############################################################################

Valuation does not allow compensation of loss
in one dimension by gain in another.
###############################################################################
-/

namespace SigmaR

/--
No compensatory reasoning is assumed.
-/
axiom no_compensatory_reasoning :
  ¬ (∃ (C : (Agent → State → Nat) → (Agent → State → Nat) → Prop),
        True)

end SigmaR
