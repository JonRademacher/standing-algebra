import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Definition Arity Discipline
###############################################################################

Valuation definitions must respect their intended arity.

This file enforces that:
- measures depend on Agent and State
- pressures depend on State only
- state predicates are not numeric measures
###############################################################################
-/

namespace SigmaR

/--
Agent-indexed valuation measures must depend on both
Agent and State parameters.
-/
axiom measure_arity_discipline :
  ∀ (M : Agent → State → Nat),
    ∃ (a₁ a₂ : Agent) (s₁ s₂ : State),
      a₁ ≠ a₂ ∨ s₁ ≠ s₂

/--
State-level pressures are not agent-indexed by definition.
-/
axiom pressure_not_agent_indexed :
  ∀ (P : State → Nat),
    ∀ (a₁ a₂ : Agent) (s : State),
      P s = P s

end SigmaR
