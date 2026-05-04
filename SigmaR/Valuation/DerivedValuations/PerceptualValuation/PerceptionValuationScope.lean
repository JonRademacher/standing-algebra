import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Perception Valuation Scope
###############################################################################

Perception valuation is always relative to an explicitly
declared scope, context, and perceptual agreement frame.

It must never be assumed to apply globally or universally.

This preserves the distinction between:
• perception and agreement
• internal and external stabilization
• personal warrant and plural alignment

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
Perception valuation is explicitly scoped and
never globally applicable by default.
-/
constant PerceptionValuationScope : Prop

end SigmaR
