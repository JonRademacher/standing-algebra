import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.ExitCostValuation.ExitCostValuation

/-!
###############################################################################
# Autonomy Depends On Exit Cost Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on exit cost valuation.

This captures that high structural exit costs reduce
effective autonomy even when formal options exist.

It does NOT:
• imply obligation to exit
• imply consent
• assert legitimacy
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnExitCostValuation A E means that autonomy
valuation A is structurally dependent on exit cost valuation E.
-/
constant AutonomyDependsOnExitCostValuation :
  AutonomyValuation → ExitCostValuation → Prop

end SigmaR
