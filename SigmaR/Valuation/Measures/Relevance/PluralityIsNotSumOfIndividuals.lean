import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

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
No implication reducing plurality to enumeration
or aggregation of agents is permitted.
-/
axiom plurality_not_sum_of_individuals :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      TreatedAsPlurality s →
      TreatedAsAggregationOfAgents G s
  )

end SigmaR

