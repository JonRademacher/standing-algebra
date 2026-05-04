import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptionValuation
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Perception Depends On Coupling
###############################################################################

This file introduces structural dependency of perception
valuation on coupling relationships.

This captures the fact that perceptual agreement
always emerges via some form of coupling, whether
internal (self–environment) or external (inter-agent).

It does NOT:
• privilege social agreement
• override personal warrant
• imply coordination or authority
###############################################################################
-/

namespace SigmaR

/--
PerceptionDependsOnCoupling P C means that perception valuation P
is structurally grounded in coupling valuation C.
-/
constant PerceptionDependsOnCoupling :
  PerceptionValuation → CouplingValuation → Prop

end SigmaR
