import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Utility Function
###############################################################################

Valuation measures in SigmaR are not utilities.
They are not assumed to represent preference satisfaction,
welfare, or optimality.
###############################################################################
-/

namespace SigmaR

/--
No implication treating valuation measures as utility
or preference functions is permitted.
-/
axiom no_utility_function :
  ¬ (
    ∃ (M : Measure),
      IsMeasure M ∧
      TreatedAsUtility M
  )

end SigmaR

