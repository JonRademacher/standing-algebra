import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Risk Valuation Scope
###############################################################################

Risk valuation is always relative to an explicitly
declared scope, context, and agreement frame.

It must never be assumed to apply globally or universally.

This preserves the distinction between:
• structural exposure and responsibility
• internal and external risk agreement
• valuation and governance

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Risk valuation is explicitly scoped and
never globally applicable by default.
-/
constant RiskValuationScope : Prop

end SigmaR
