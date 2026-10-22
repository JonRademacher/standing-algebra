import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskAgreement

/-!
###############################################################################
# External Risk Agreement
###############################################################################

This file introduces externalized risk agreement.

External risk agreement represents stabilized plural
assessment of risk exposure across agents.

It does NOT:
• override internal risk agreement
• imply authority
• assert correctness
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.RiskValuation

/--
ExternalRiskAgreement A means that risk agreement A
is externalized across multiple agents.
-/
axiom ExternalRiskAgreement :
  RiskAgreement → Prop

end SigmaR.Valuation.DerivedValuations.RiskValuation
