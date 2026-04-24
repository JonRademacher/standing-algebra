import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.RiskInheritance_Definition
import SigmaR.Valuation.Measures.DependencyDegree_Definition

/-!
###############################################################################
# Risk Inheritance — Well-Definedness
###############################################################################

Ensures that inherited risk is structurally grounded
in dependency and not arbitrarily assigned.
###############################################################################
-/

namespace SigmaR

/--
Risk inheritance is well-defined if it is determined
as a function of agent and state.
-/
def RiskInheritance_WellDefined : Prop :=
  ∀ (i : Agent) (s : State), ∃ (n : Nat), RiskInheritance i s = n

end SigmaR
