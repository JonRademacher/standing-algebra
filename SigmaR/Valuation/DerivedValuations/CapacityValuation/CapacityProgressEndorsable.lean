import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CapacityValuation.CapacityProgressOptionSet

/-!
###############################################################################
# Capacity Progress Endorsable
###############################################################################

This file introduces endorsability of capacity-progress
options under declared structural constraints.

Endorsability does NOT imply preference or selection.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CapacityValuation

/--
CapacityProgressEndorsable S means that the capacity-progress
options in S are structurally endorsable.
-/
axiom CapacityProgressEndorsable :
  CapacityProgressOptionSet → Prop

end SigmaR.Valuation.DerivedValuations.CapacityValuation
