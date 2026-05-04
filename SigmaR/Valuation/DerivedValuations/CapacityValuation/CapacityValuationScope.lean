import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Capacity Valuation Scope
###############################################################################

Capacity valuation is always relative to an explicitly
declared scope, context, and agreement frame.

It must never be assumed to apply globally or universally.

This preserves the distinction between:
• structural capacity and effective capacity
• internal and external capacity agreement
• valuation and governance

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Capacity valuation is explicitly scoped and
never globally applicable by default.
-/
constant CapacityValuationScope : Prop

end SigmaR
