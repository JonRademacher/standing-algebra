import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Autonomy Depends On Coupling Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on coupling valuation.

This captures that dependency, proxy control, or relational
entanglement constrain effective autonomy.

It does NOT:
• assert domination
• imply fault
• imply authority
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnCouplingValuation A C means that autonomy
valuation A is structurally dependent on coupling valuation C.
-/
constant AutonomyDependsOnCouplingValuation :
  AutonomyValuation → CouplingValuation → Prop

end SigmaR
