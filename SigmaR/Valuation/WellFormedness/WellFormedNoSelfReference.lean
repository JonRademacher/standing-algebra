import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed No Self-Reference
###############################################################################

Valuation expressions must not be defined directly
in terms of themselves.

This file prevents immediate self-dependence and
fixed-point style definitions.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may directly depend on itself.
-/
axiom no_self_reference :
  ¬ (
    ∃ (M : Agent → State → Nat),
      IsMeasure M ∧
      DependsOn M M
  )

end SigmaR

