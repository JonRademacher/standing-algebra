import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.RiskLoad_Definition

/-!
###############################################################################
# Risk Load — Well-Definedness
###############################################################################

Ensures that risk load is a total, state-relative valuation measure.
No assumptions about probability, expectation, or aggregation are made.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

/--
Risk load is well-defined if it assigns a natural number
to every agent.
-/
def RiskLoad_WellDefined : Prop :=
  ∀ (i : Agent), ∃ (n : Nat), SigmaR.Valuation.Measures.Definitions.RiskLoad i = n

end SigmaR.Valuation.Measures.WellDefinedness
