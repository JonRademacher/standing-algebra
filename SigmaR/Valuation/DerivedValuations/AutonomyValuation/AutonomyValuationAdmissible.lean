import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyValuation

/-!
###############################################################################
# Autonomy Valuation Admissible
###############################################################################

This file introduces admissibility constraints for
autonomy valuation.

Admissibility governs whether an autonomy valuation
may be used in reasoning.

It does NOT:
• imply consent
• imply legitimacy
• authorize intervention or action
###############################################################################
-/

namespace SigmaR

/--
AutonomyValuationAdmissible A means that autonomy valuation A
is admissible under declared structural constraints.
-/
constant AutonomyValuationAdmissible :
  AutonomyValuation → Prop

end SigmaR
