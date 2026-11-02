import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Irreversibility
###############################################################################

This file introduces irreversibility specific to
autonomy valuations.

Autonomy irreversibility does NOT imply:
• moral absolutism
• inevitability of response
• authority to act

It is descriptive only.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
AutonomyIrreversibility A means that autonomy valuation A
is structurally irreversible once lost.
-/
axiom AutonomyIrreversibility :
  AutonomyValuation → Prop

end SigmaR.Valuation.DerivedValuations.AutonomyValuation
