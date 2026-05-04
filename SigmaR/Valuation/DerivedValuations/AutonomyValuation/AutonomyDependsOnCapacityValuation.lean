import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Autonomy Depends On Capacity Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on capacity valuation.

This captures that effective autonomy is bounded by
usable capacity without implying competence or merit.

It does NOT:
• imply responsibility
• imply legitimacy
• assert obligation
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnCapacityValuation A C means that autonomy
valuation A is structurally dependent on capacity valuation C.
-/
constant AutonomyDependsOnCapacityValuation :
  AutonomyValuation → CapacityValuation → Prop

end SigmaR
