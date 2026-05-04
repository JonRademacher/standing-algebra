import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Autonomy Depends On Risk Valuation
###############################################################################

This file introduces structural dependency of autonomy
valuation on risk valuation.

This captures that structural exposure, vulnerability,
and accumulated risk constrain effective autonomy.

It does NOT:
• imply fault
• imply consent
• justify intervention
###############################################################################
-/

namespace SigmaR

/--
AutonomyDependsOnRiskValuation A R means that autonomy
valuation A is structurally dependent on risk valuation R.
-/
constant AutonomyDependsOnRiskValuation :
  AutonomyValuation → RiskValuation → Prop

end SigmaR
