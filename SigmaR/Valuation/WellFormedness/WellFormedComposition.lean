import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Composition
###############################################################################

Composition of valuation expressions must preserve
structural well-formedness.

This file prevents arbitrary or ill-typed compositions
from being treated as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
There is no general rule that composing valuation measures
(or composing measures with arbitrary functions) yields
a valuation measure.

Only explicitly sanctioned compositions are well-formed.
-/
axiom no_arbitrary_composition_as_measure :
  ¬ (
    ∀ (M₁ M₂ : Agent → State → Nat),
      IsMeasure M₁ →
      IsMeasure M₂ →
      IsMeasure (fun a s => M₁ a s + M₂ a s)
  )

end SigmaR

