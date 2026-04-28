import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Measure Targeting
###############################################################################

Valuation measures are not targets to be optimized.
They are descriptive, not prescriptive.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure is assumed to be a target of action.
-/
axiom no_measure_targeting :
  ¬ (∃ (M : Agent → State → Nat),
        True)

end SigmaR
