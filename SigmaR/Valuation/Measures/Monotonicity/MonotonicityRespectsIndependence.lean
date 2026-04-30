import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Independence.IndependenceContract
import SigmaR.Valuation.Measures.Monotonicity.MonotonicityContract

/-!
###############################################################################
# Monotonicity Respects Independence (Contract)
###############################################################################

Monotonicity constrains how a single measure may evolve with
respect to state progression.

Independence constrains what inferences may be drawn between
distinct measures.

Monotonicity must never be used to reintroduce implications
explicitly blocked by the Independence layer.

This file introduces no axioms.
It names a binding interpretive boundary between the two layers.
###############################################################################
-/

namespace SigmaR

/--
Monotonicity relations are treated as respecting
Independence inference boundaries.
-/
constant MonotonicityRespectsIndependence : Prop

end SigmaR
