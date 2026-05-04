import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation

/-!
###############################################################################
# Perception Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
perception valuation.

Admissibility governs whether a perception valuation
may be used in reasoning.

It does NOT imply:
• correctness
• truth
• legitimacy
• authority
• intervention
###############################################################################
-/

namespace SigmaR

/--
PerceptionValuationAdmissible P means that perception valuation P
is admissible under declared structural constraints.
-/
constant PerceptionValuationAdmissible :
  PerceptionValuation → Prop

end SigmaR
