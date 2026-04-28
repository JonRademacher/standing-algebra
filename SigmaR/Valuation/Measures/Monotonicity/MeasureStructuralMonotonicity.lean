import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure Structural Monotonicity
###############################################################################

Structural refinement of a state does not decrease valuation measures.

This axiom is abstract: it does not assume time, continuity,
or numeric interpretation.
###############################################################################
-/

namespace SigmaR

/--
An abstract preorder over states.
Interpreted as refinement, progression, or extension.
-/
constant StateLe : State → State → Prop

/--
Generic structural monotonicity for valuation measures.
-/
axiom measure_structural_monotone :
  ∀ (M : Agent → State → Nat)
    (a : Agent) (s₁ s₂ : State),
    StateLe s₁ s₂ →
    M a s₁ ≤ M a s₂

end SigmaR
