import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition

/-!
###############################################################################
# Risk Inheritance Is Monotone (Structural)
###############################################################################

Risk inheritance is treated as non-decreasing
along the state preorder within certain models
or interpretive regimes.

This file names the monotonicity relationship.
It does not assert it as a global semantic law.
###############################################################################
-/

namespace SigmaR

/--
Risk inheritance is treated as monotone
along the state preorder.
-/
axiom RiskInheritanceMonotone : Prop

end SigmaR
