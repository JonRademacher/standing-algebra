import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Imply Ordering
###############################################################################

Equivalence does not induce an ordering over
agents, states, or measures.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not permit ordering or ranking.
-/
axiom equivalence_not_ordering :
  ¬ (∃ (rank : (Agent → State → Nat) → Nat),
        True)

end SigmaR
