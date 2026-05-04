import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOptionSet

/-!
###############################################################################
# Transformability Progress Endorsable
###############################################################################

This file introduces endorsability of transformability-progress
options under declared structural constraints.

Endorsability does NOT imply preference or selection.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityProgressEndorsable S means that the
transformability-progress options in S are structurally endorsable.
-/
constant TransformabilityProgressEndorsable :
  TransformabilityProgressOptionSet → Prop

end SigmaR
