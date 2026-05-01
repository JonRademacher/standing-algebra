import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

/-!
###############################################################################
# Coupling Amplification
###############################################################################

This file introduces the structural notion that coupling
valuation effects may be amplified.

Amplification does NOT imply:
• escalation policy
• desirability
• moral weight

It is directional structure only.
###############################################################################
-/

namespace SigmaR

/--
CouplingAmplification C₁ C₂ means that coupling valuation C₁
amplifies the effect of coupling valuation C₂.
-/
constant CouplingAmplification :
  CouplingValuation → CouplingValuation → Prop

end SigmaR
