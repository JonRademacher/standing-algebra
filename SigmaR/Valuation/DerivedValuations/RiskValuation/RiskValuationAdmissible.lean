import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
risk valuation.

Admissibility governs whether a risk valuation may be
used in reasoning.

It does NOT:
• imply correctness
• imply fault or culpability
• authorize intervention or action
###############################################################################
-/

namespace SigmaR

/--
RiskValuationAdmissible R means that risk valuation R
is admissible under declared structural constraints.
-/
constant RiskValuationAdmissible :
  RiskValuation → Prop

end SigmaR
