import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Legitimacy
###############################################################################

The fact that something is measured or observed does not
confer legitimacy, authority, or justification.

Measurement does not license legitimacy.
###############################################################################
-/

namespace SigmaR

/--
No implication from measurement to legitimacy is permitted.
-/
axiom measurement_not_legitimacy :
  ¬ (
    ∀ (a : Agent) (s : State),
      Observable a s →
      Legitimate s
  )

end SigmaR

