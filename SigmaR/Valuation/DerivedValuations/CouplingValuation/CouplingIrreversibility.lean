import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.CouplingValuation

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

namespace SigmaR

/--
CouplingIrreversibility C means that coupling valuation C
is structurally irreversible once lost.
-/
constant CouplingIrreversibility :
  CouplingValuation → Prop

end SigmaR
