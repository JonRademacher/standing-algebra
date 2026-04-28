import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Aggregate Optimization
###############################################################################

Distinct valuation dimensions must not be aggregated
into a single optimizing quantity.
###############################################################################
-/

namespace SigmaR

/--
No aggregate optimization over multiple measures is assumed.
-/
axiom no_aggregate_optimization :
  ¬ (∃ (F : (Agent → State → Nat) → Nat),
        True)

end SigmaR
