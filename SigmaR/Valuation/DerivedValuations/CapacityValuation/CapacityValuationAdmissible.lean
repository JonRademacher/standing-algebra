import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityValuation

/-!
###############################################################################
# Capacity Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
capacity valuation.

Admissibility governs whether a capacity valuation
may be used in reasoning.

It does NOT:
• imply correctness
• imply merit
• authorize intervention
###############################################################################
-/

namespace SigmaR

/--
CapacityValuationAdmissible C means that capacity valuation C
is admissible under declared structural constraints.
-/
constant CapacityValuationAdmissible :
  CapacityValuation → Prop

end SigmaR
