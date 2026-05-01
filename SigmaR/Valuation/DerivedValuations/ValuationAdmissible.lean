import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
derived valuations.

Admissibility does NOT imply:
• correctness
• legitimacy
• authority
• intervention

It only governs permission to reason with a valuation.
###############################################################################
-/

namespace SigmaR

/--
ValuationAdmissible V means that derived valuation V
is admissible under declared structural constraints.
-/
constant ValuationAdmissible :
  DerivedValuation → Prop

end SigmaR
