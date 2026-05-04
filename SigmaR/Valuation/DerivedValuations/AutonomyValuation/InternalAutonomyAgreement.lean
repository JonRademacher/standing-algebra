import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyAgreement

/-!
###############################################################################
# Internal Autonomy Agreement
###############################################################################

This file introduces internalized autonomy agreement.

Internal autonomy agreement reflects an agent’s stabilized
self-assessment of their own autonomy.

It grounds personal warrant and does NOT depend on
external validation.
###############################################################################
-/

namespace SigmaR

/--
InternalAutonomyAgreement A means that autonomy agreement A
is internalized within a single agent.
-/
constant InternalAutonomyAgreement :
  AutonomyAgreement → Prop

end SigmaR
