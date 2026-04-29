import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Local Scope
###############################################################################

Locally scoped valuation expressions must remain
explicitly bound to their local context.

This file prevents implicit or accidental localization
of valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may be treated as locally scoped
unless it is explicitly declared local.
-/
axiom no_implicit_local_scope :
  ¬ (
    ∀ (M : Agent → State → Nat),
      IsMeasure M →
      IsLocalScope M
  )

end SigmaR
