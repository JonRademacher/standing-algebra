import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOptionSet

/-!
###############################################################################
# Transformability Progress Available
###############################################################################

This file introduces the condition that transformability-progress
options are available in the current structural context.

Availability states existence, not obligation.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityProgressAvailable S means that a set of
transformability-progress options S exists.
-/
axiom TransformabilityProgressAvailable :
  TransformabilityProgressOptionSet → Prop

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
