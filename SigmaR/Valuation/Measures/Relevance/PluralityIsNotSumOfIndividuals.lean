import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Plurality Is Not the Sum of Individuals
###############################################################################

Plurality is not reducible to a collection, aggregation,
or enumeration of individual agents.

It is a structural property of the frame space.
###############################################################################
-/

namespace SigmaR

/--
Plurality does not arise from counting agents.
-/
axiom plurality_not_sum_of_individuals :
  ¬ (∃ (G : Set Agent),
        True)

end SigmaR
