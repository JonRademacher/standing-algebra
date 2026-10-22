import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

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

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
CouplingAmplification C₁ C₂ means that coupling valuation C₁
amplifies the effect of coupling valuation C₂.
-/
axiom CouplingAmplification :
  CouplingValuation → CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation
