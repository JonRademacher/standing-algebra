import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Valuation.Measures.Monotonicity.MeasureStructuralMonotonicity

/-!
###############################################################################
# Structural Debt Is Monotone (Structural)
###############################################################################

Structural debt is treated as non-decreasing
along the state preorder in the absence of
explicit repair or resolution mechanisms.

This file names the monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Structural debt is treated as monotone
along the state preorder.
-/
constant StructuralDebtMonotone : Prop

end SigmaR
