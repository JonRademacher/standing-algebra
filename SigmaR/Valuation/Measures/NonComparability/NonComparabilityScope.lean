import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Scope
###############################################################################

Non-comparability applies only where explicitly declared.
It is not assumed globally, but must be respected
where asserted.
###############################################################################
-/

namespace SigmaR

/--
Non-comparability is not overridden by default.
-/
axiom noncomparability_scope :
  ∀ (M₁ M₂ : Agent → State → Nat),
    True

end SigmaR
