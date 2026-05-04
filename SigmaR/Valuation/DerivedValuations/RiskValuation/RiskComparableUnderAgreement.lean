import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskAgreement

/-!
###############################################################################
# Risk Comparable Under Agreement
###############################################################################

This file introduces comparability of risk valuations
conditioned on a specific risk agreement.

This captures that some comparisons are only meaningful
relative to an agreement locus (internal or external).

It does NOT:
• privilege consensus
• override personal warrant
• assert correctness
###############################################################################
-/

namespace SigmaR

/--
RiskComparableUnderAgreement R₁ R₂ A means that
risk valuations R₁ and R₂ are structurally comparable
under risk agreement A.
-/
constant RiskComparableUnderAgreement :
  RiskValuation → RiskValuation → RiskAgreement → Prop

end SigmaR
