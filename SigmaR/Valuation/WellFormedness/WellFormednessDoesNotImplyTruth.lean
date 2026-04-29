import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formedness Does Not Imply Truth
###############################################################################

Structural well-formedness does not imply truth,
correctness, or correspondence with reality.

Truth is not a structural property.
###############################################################################
-/

namespace SigmaR

/--
No implication from well-formedness to truth is permitted.
-/
axiom wellformedness_not_truth :
  ¬ (
    ∀ (M : Agent → State → Nat),
      WellFormed M → TrueMeasure M
  )

end SigmaR

