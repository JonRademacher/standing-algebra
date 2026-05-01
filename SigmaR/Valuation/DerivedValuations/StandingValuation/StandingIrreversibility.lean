import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.StandingValuation

/-!
###############################################################################
# Standing Irreversibility
###############################################################################

This file introduces irreversibility specific to
standing valuations.

Irreversibility does NOT imply:
• moral finality
• inevitability of intervention
• authority to act

It is descriptive only.
###############################################################################
-/

namespace SigmaR

/--
StandingIrreversibility S means that standing valuation S
is structurally irreversible once lost.
-/
constant StandingIrreversibility :
  StandingValuation → Prop

end SigmaR
