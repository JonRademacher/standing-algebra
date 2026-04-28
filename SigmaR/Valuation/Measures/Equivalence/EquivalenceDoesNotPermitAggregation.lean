import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Does Not Permit Aggregation
###############################################################################

Equivalence does not permit aggregation of
valuation measures into a single quantity.
###############################################################################
-/

namespace SigmaR

/--
Equivalence does not allow aggregation of measures.
-/
axiom equivalence_not_aggregation :
  ¬ (∃ (F : (Agent → State → Nat) → Nat),
        True)

end SigmaR
