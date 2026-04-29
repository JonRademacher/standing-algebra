import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Global Scope
###############################################################################

Globally scoped valuation expressions must be
explicitly marked as such.

This file prevents implicit or accidental globalization
of locally scoped valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may be treated as globally scoped
unless it is explicitly declared global.
-/
axiom no_implicit_global_scope :
  ¬ (
    ∀ (M : Agent → State → Nat),
      IsMeasure M →
      IsGlobalScope M
  )

end SigmaR

