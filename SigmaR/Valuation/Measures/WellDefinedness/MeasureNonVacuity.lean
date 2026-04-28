import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measure Non-Vacuity
###############################################################################

Well-defined measures must be capable of variation.
They may be constant in a particular model, but not
definitionally incapable of change.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure is non-vacuous if there exist two
states at which it may differ.
-/
axiom measure_non_vacuous :
  ∀ (M : Agent → State → Nat),
    ∃ (a : Agent) (s₁ s₂ : State),
      M a s₁ ≠ M a s₂

end SigmaR
