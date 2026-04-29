import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Definition Arity Discipline
###############################################################################

Valuation definitions must respect their intended arity.

This file blocks illicit reinterpretation of definitions
across arity boundaries.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting an agent–state valuation
to be treated as agent-independent is allowed.
-/
axiom measure_requires_agent_dependency :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      ∃ (f : State → Nat),
        ∀ (a : Agent) (s : State),
          M a s = f s
  )

/--
No implication permitting a state-level quantity
to be treated as agent-indexed is allowed.
-/
axiom pressure_not_agent_indexed :
  ¬ (
    ∀ (P : State → Nat),
      ∃ (M : Measure),
        ∀ (a : Agent) (s : State),
          M a s = P s
  )

end SigmaR
