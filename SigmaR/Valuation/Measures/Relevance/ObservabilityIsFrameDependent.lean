import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Observability Is Frame Dependent
###############################################################################

Observability depends on the perceptual frame or descriptive
context used by the agent.
###############################################################################
-/

namespace SigmaR

/--
Different perceptual frames may yield different observables
for the same agent and state.
-/
axiom observability_is_frame_dependent :
  ∃ (a : Agent) (s : State) (f₁ f₂ : Frame),
    f₁ ≠ f₂ ∧
    (ObservableInFrame a f₁ s ↔ ¬ ObservableInFrame a f₂ s)

end SigmaR
