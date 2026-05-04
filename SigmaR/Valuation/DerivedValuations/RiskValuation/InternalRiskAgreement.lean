import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskAgreement

/-!
###############################################################################
# Internal Risk Agreement
###############################################################################

This file introduces internalized risk agreement.

Internal risk agreement reflects an agent’s stabilized
recognition of their own risk exposure.

It grounds personal warrant and does NOT depend on
external validation.
###############################################################################
-/

namespace SigmaR

/--
InternalRiskAgreement A means that risk agreement A
is internalized within a single agent.
-/
constant InternalRiskAgreement :
  RiskAgreement → Prop

end SigmaR
