import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.DerivedValuation

/-!
###############################################################################
# Valuation Irreversibility
###############################################################################

This file introduces irreversibility at the level
of derived valuations.

Irreversibility does NOT imply:
• permanence in reality
• moral finality
• prohibition of intervention

It is a valuation-level property only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations

/--
ValuationIrreversibility V means that valuation V
cannot be structurally restored once lost.
-/
axiom ValuationIrreversibility :
  DerivedValuation → Prop

end SigmaR.Valuation.DerivedValuations
