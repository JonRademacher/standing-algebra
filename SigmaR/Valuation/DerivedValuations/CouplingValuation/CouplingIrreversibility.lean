import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation.CouplingValuation

/-!
###############################################################################
# Coupling Irreversibility
###############################################################################

This file introduces irreversibility specific to
coupling valuations.

Irreversibility does NOT imply:
• permanence in reality
• moral finality
• authority to act

It is descriptive only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.CouplingValuation

/--
CouplingIrreversibility C means that coupling valuation C
is structurally irreversible once lost.
-/
axiom CouplingIrreversibility :
  CouplingValuation → Prop

end SigmaR.Valuation.DerivedValuations.CouplingValuation
