import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.DominationPressure_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Domination Pressure Is Monotone (Structural)
###############################################################################

Domination pressure is treated as non-decreasing
along the state preorder unless countervailing
structure is present.

This file names the monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Monotonicity

/--
Domination pressure is treated as monotone
along the state preorder.
-/
axiom DominationPressureMonotone : Prop

end SigmaR.Valuation.Measures.Monotonicity
