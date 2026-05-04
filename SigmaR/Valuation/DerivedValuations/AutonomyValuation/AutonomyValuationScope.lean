import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Autonomy Valuation Scope
###############################################################################

Autonomy valuation is always relative to an explicitly
declared scope, context, and agreement frame.

It must never be assumed to apply globally or universally.

This preserves the distinction between:
• formal agency and effective autonomy
• internal and external autonomy agreement
• valuation and governance

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Autonomy valuation is explicitly scoped and
never globally applicable by default.
-/
constant AutonomyValuationScope : Prop

end SigmaR
