import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.ExitCostValuation

/-!
###############################################################################
# Exit Cost Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
exit cost valuations.

Admissibility does NOT imply:
• correctness
• legitimacy
• authority
• intervention

It only governs permission to reason with an exit cost valuation.
###############################################################################
-/

namespace SigmaR

/--
ExitCostValuationAdmissible E means that exit cost valuation E
is admissible under declared structural constraints.
-/
constant ExitCostValuationAdmissible :
  ExitCostValuation → Prop

end SigmaR
