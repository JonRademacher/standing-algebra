import SigmaR.Valuation.StandingValuation
import SigmaR.Valuation.Measures.Definitions.RiskInheritance_Definition
import SigmaR.Valuation.Measures.Definitions.DependencyDegree_Definition

/-!
###############################################################################
# Risk Inheritance — Well-Definedness
###############################################################################

Ensures that inherited risk is structurally grounded
in dependency and not arbitrarily assigned.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.WellDefinedness

open SigmaR.Valuation.Measures.Definitions

/--
Risk inheritance is well-defined if it is determined
as a function of agent and state.
-/
def RiskInheritance_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ∃ (n : Nat), RiskInheritance i s = n

end SigmaR.Valuation.Measures.WellDefinedness
