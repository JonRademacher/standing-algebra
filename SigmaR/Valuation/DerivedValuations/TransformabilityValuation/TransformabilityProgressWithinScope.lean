import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOptionSet

/-!
###############################################################################
# Transformability Progress Within Scope
###############################################################################

This file introduces the condition that transformability-progress
options lie within the effective scope of transformation.

Scope captures feasibility and control, not preference.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityProgressWithinScope S means that the
transformability-progress options in S are within scope.
-/
constant TransformabilityProgressWithinScope :
  TransformabilityProgressOptionSet → Prop

end SigmaR
