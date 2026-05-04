import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.AutonomyValuation.AutonomyAgreement

/-!
###############################################################################
# External Autonomy Agreement
###############################################################################

This file introduces externalized autonomy agreement.

External autonomy agreement represents stabilized plural
assessment of autonomy across agents.

It does NOT:
• override internal autonomy agreement
• imply authority
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
ExternalAutonomyAgreement A means that autonomy agreement A
is externalized across multiple agents.
-/
constant ExternalAutonomyAgreement :
  AutonomyAgreement → Prop

end SigmaR
