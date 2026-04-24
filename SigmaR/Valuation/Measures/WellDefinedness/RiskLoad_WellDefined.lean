import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition

/-!
###############################################################################
# Risk Load — Well-Definedness
###############################################################################

Ensures that risk load is a total, state-relative valuation measure.
No assumptions about probability, expectation, or aggregation are made.
###############################################################################
-/

namespace SigmaR

/--
Risk load is well-defined if it assigns a natural number
to every agent in every state.
-/
def RiskLoad_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ∃ (n : Nat), RiskInheritance i s = n

end SigmaR
