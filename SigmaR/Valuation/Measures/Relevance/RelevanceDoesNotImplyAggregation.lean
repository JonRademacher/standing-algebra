import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Does Not Imply Aggregation
###############################################################################

Relevance does not by itself justify aggregation.
Aggregation requires collective warrant (PFA).
###############################################################################
-/

namespace SigmaR

/--
Relevance does not imply permission to aggregate.
-/
axiom relevance_not_aggregation :
  ¬ (∃ (A : (Agent → State → Nat) → Nat),
        True)

end SigmaR
