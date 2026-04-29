import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Projection
###############################################################################

Projection of valuation expressions must preserve
required structural properties.

This file prevents projection from erasing required
structure and silently yielding a valuation measure.
###############################################################################
-/

namespace SigmaR

/--
There is no general rule that projecting a valuation
expression yields another valuation measure.

Only explicitly sanctioned projections are well-formed.
-/
axiom no_arbitrary_projection_as_measure :
  ¬ (
    ∀ (M : Agent → State → Nat),
      IsMeasure M →
      IsMeasure (Project M)
  )

end SigmaR
