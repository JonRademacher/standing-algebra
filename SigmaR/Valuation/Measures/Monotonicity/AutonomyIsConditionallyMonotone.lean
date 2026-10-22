import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Autonomy Is Conditionally Monotone (Structural)
###############################################################################

Autonomy is conditionally non-increasing with respect to
domination pressure under admissible state transitions.

This file *names* the monotonicity relationship.
It does not assert it globally or unconditionally.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Monotonicity

/--
Autonomy is treated as conditionally monotone decreasing
with respect to domination pressure along the state preorder.
-/
axiom AutonomyConditionallyMonotoneUnderDomination :
  Agent → Prop

end SigmaR.Valuation.Measures.Monotonicity
