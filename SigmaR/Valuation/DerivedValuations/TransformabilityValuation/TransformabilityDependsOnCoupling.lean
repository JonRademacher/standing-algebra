import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityValuation
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Transformability Depends On Coupling
###############################################################################

This file introduces structural dependency of transformability
valuation on coupling relationships.

This captures that the ability to transform state may be
constrained or enabled by relational structure.

It does NOT:
• imply domination
• assert authority
• redefine autonomy
###############################################################################
-/

namespace SigmaR

/--
TransformabilityDependsOnCoupling T K means that transformability
valuation T is structurally grounded in coupling valuation K.
-/
constant TransformabilityDependsOnCoupling :
  TransformabilityValuation → CouplingValuation → Prop

end SigmaR
