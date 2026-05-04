import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.RiskValuation.RiskValuation

/-!
###############################################################################
# Risk Inheritance
###############################################################################

This file introduces inheritance of risk valuation.

Risk inheritance captures transfer of structural exposure
through dependency or relational structure.

It does NOT:
• imply responsibility
• assign fault
• assert consent
###############################################################################
-/

namespace SigmaR

/--
RiskInheritance R₁ R₂ means that risk valuation R₂
inherits structural risk from R₁.
-/
constant RiskInheritance :
  RiskValuation → RiskValuation → Prop

end SigmaR
