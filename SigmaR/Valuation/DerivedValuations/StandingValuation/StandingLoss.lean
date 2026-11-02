import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation.StandingValuation

/-!
###############################################################################
# Standing Loss
###############################################################################

This file introduces the structural notion of loss
for standing valuations.

Standing loss does NOT imply:
• injustice
• wrongdoing
• obligation to respond
• legitimacy of intervention

It is a descriptive valuation change only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.StandingValuation

/--
StandingLoss S₁ S₂ means that standing valuation S₂
represents a loss relative to standing valuation S₁.
-/
axiom StandingLoss :
  StandingValuation → StandingValuation → Prop

end SigmaR.Valuation.DerivedValuations.StandingValuation
