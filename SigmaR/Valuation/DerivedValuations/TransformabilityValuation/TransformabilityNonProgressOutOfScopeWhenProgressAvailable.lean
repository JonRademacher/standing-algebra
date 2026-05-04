import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOptionSet

/-!
###############################################################################
# Transformability Non-Progress Out Of Scope When Progress Available
###############################################################################

This file encodes the transformability ratchet boundary:

When transformability-progress options exist within scope,
non-transforming paths become out of scope for
non-dominating evaluation.

This is NOT preference or optimization.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityNonProgressOutOfScopeWhenProgressAvailable S
means that non-progress options are out of scope when
progress options S are available.
-/
constant TransformabilityNonProgressOutOfScopeWhenProgressAvailable :
  TransformabilityProgressOptionSet → Prop

end SigmaR
