import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Level
###############################################################################

This file introduces the notion of a risk level.

Risk levels represent the magnitude of structural risk exposure,
without normative interpretation.

They do NOT:
• imply culpability
• assert acceptability
• justify mitigation
###############################################################################
-/

namespace SigmaR

/--
A risk level associated with a risk valuation.
-/
constant RiskLevel :
  RiskValuation → Val

end SigmaR
