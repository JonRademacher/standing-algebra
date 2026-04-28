import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Definition No Dynamics
###############################################################################

Definitions must be static mappings.

They must not encode temporal progression, state evolution,
or dynamic behavior.
###############################################################################
-/

namespace SigmaR

/--
Valuation definitions must not encode dynamic behavior.

Evolution and change are handled by Monotonicity and models,
not by primitive definitions.
-/
axiom definition_no_dynamics :
  ∀ (M : Agent → State → Nat),
    ¬ (∃ (s₁ s₂ : State),
         M = fun a s =>
           if s = s₁ then M a s₂ else M a s)

end SigmaR
