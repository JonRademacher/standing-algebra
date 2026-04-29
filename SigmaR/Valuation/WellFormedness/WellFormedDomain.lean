import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Domain
###############################################################################

Valuation measures must have explicit and coherent domains.

This file prevents partial, restricted, or implicitly narrowed
domain functions from being treated as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may rely on an implicit or restricted domain.

Functions that are only meaningful on a proper subset of states
must not be treated as valuation measures unless explicitly
admitted elsewhere.
-/
axiom no_implicit_domain_restriction :
  ¬ (
    ∀ (M : Agent → State → Nat),
      RestrictsDomain M →
      IsMeasure M
  )

end SigmaR

