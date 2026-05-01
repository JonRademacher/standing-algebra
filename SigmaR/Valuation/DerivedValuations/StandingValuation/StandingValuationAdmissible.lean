import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
standing valuations.

Admissibility does NOT imply:
• correctness
• legitimacy
• authority
• intervention

It only governs permission to reason with a standing valuation.
###############################################################################
-/

namespace SigmaR

/--
StandingValuationAdmissible S means that standing valuation S
is admissible under declared structural constraints.
-/
constant StandingValuationAdmissible :
  StandingValuation → Prop

end SigmaR
