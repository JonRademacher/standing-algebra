import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formedness Does Not Imply Validity
###############################################################################

Structural well-formedness does not imply semantic,
contextual, or normative validity.

Validity is governed by separate admissibility criteria.
###############################################################################
-/

namespace SigmaR

/--
No implication from well-formedness to validity is permitted.
-/
axiom wellformedness_not_validity :
  ¬ (
    ∀ (M : Agent → State → Nat),
      WellFormed M → Valid M
  )

end SigmaR
