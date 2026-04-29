import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formedness Does Not Imply Legitimacy
###############################################################################

Structural well-formedness does not confer legitimacy,
authority, or justification.
###############################################################################
-/

namespace SigmaR

/--
No implication from well-formedness to legitimacy is permitted.
-/
axiom wellformedness_not_legitimacy :
  ¬ (
    ∀ (M : Agent → State → Nat),
      WellFormed M → Legitimate M
  )

end SigmaR
