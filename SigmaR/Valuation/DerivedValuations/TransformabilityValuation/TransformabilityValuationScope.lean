import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Transformability Valuation Scope
###############################################################################

Transformability valuation is always relative to an explicitly
declared scope, context, and agreement frame.

It must never be assumed to apply globally or universally.

This preserves the distinction between:
• structural operations and effective transformability
• internal and external transformability agreement
• valuation and governance

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Transformability valuation is explicitly scoped and
never globally applicable by default.
-/
constant TransformabilityValuationScope : Prop

end SigmaR
