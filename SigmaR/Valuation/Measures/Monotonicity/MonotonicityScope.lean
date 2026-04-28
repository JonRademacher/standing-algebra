import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Scope
###############################################################################

Monotonicity axioms apply only within an explicitly
declared state ordering and system context.

They do not apply globally or across unrelated states.
###############################################################################
-/

namespace SigmaR

/--
An abstract preorder over states.
Interpreted as progression, refinement, or extension.
-/
constant StateLe : State → State → Prop

/--
Monotonicity is only meaningful relative to a state ordering.
-/
axiom monotonicity_requires_scope :
  ∀ (s₁ s₂ : State),
    StateLe s₁ s₂ ∨ ¬ StateLe s₁ s₂

end SigmaR
