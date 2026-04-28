import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure State Sensitivity
###############################################################################

Well-defined measures must be sensitive to state.
They may be constant over regions, but not independent
of state altogether.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure must depend on the state dimension.
-/
axiom measure_state_sensitive :
  ∀ (M : Agent → State → Nat),
    ∃ (a : Agent) (s₁ s₂ : State),
      M a s₁ ≠ M a s₂

end SigmaR
