import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOptionSet

/-!
###############################################################################
# Transformability Omission Maintains Constraint
###############################################################################

This file introduces the notion that omission of
transformability-progress usage maintains a structural
constraint when progress was available.

This names omission structurally, not morally.
###############################################################################
-/

namespace SigmaR

/--
TransformabilityOmissionMaintainsConstraint S means that
failure to engage available transformability-progress options
maintains the transformability constraint structurally.
-/
constant TransformabilityOmissionMaintainsConstraint :
  TransformabilityProgressOptionSet → Prop

end SigmaR
