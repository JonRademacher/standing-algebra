import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Restriction
###############################################################################

Restriction of valuation expressions must be explicit
and structurally coherent.

This file prevents restriction from being used to
silently preserve measure status.
###############################################################################
-/

namespace SigmaR

/--
There is no general rule that restricting a valuation
expression yields another valuation measure.

Only explicitly admitted restrictions are well-formed.
-/
axiom no_arbitrary_restriction_as_measure :
  ¬ (
    ∀ (M : Agent → State → Nat) (P : Agent → State → Prop),
      IsMeasure M →
      IsMeasure (Restrict M P)
  )

end SigmaR

