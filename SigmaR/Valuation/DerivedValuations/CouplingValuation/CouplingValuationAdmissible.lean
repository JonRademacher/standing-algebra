import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
coupling valuations.

Admissibility does NOT imply:
• correctness
• legitimacy
• authority
• intervention

It only governs permission to reason with a coupling valuation.
###############################################################################
-/

namespace SigmaR

/--
CouplingValuationAdmissible C means that coupling valuation C
is admissible under declared structural constraints.
-/
constant CouplingValuationAdmissible :
  CouplingValuation → Prop

end SigmaR
