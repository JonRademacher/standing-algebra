import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.PerceptualValuation.PerceptionValuation

/-!
###############################################################################
# Perception Irreversibility
###############################################################################

This file introduces irreversibility specific to
perception valuation.

Irreversibility does NOT imply:
• permanence in reality
• error or falsehood
• authority to override perception

It is descriptive only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.PerceptualValuation

/--
PerceptionIrreversibility P means that perception valuation P
is structurally irreversible once degraded.
-/
axiom PerceptionIrreversibility :
  PerceptionValuation → Prop

end SigmaR.Valuation.DerivedValuations.PerceptualValuation
