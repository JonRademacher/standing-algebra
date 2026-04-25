import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AgencyScope_Definition

/-!
###############################################################################
# Agency Scope — Well-Definedness
###############################################################################

Ensures agency scope is a total, non-negative
valuation quantity for all agents and states.

No monotonicity, legitimacy, or admissibility
claims are made here.
###############################################################################
-/

namespace SigmaR

/--
AgencyScope is well-defined if it yields a natural number
for every agent in every state.
-/
def AgencyScope_WellDefined : Prop :=
  ∀ (a : Agent) (s : State), ∃ (n : Nat), AgencyScope a s = n

end SigmaR
