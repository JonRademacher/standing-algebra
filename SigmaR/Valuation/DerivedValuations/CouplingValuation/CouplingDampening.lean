import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Dampening
###############################################################################

This file introduces the structural notion that coupling
valuation effects may be dampened.

Dampening does NOT imply:
• mitigation policy
• repair
• moral improvement

It is directional structure only.
###############################################################################
-/

namespace SigmaR

/--
CouplingDampening C₁ C₂ means that coupling valuation C₁
dampens the effect of coupling valuation C₂.
-/
constant CouplingDampening :
  CouplingValuation → CouplingValuation → Prop

end SigmaR
