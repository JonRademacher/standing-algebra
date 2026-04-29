import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Monotone Improvement
###############################################################################

Monotonicity does not imply improvement, benefit,
or desirability.

A value may evolve monotonically without becoming "better".
###############################################################################
-/

namespace SigmaR

/--
No implication from monotonicity to improvement,
benefit, or desirability is permitted.
-/
axiom no_monotone_improvement :
  ¬ (
    ∃ (M : Measure),
      IsMeasure M ∧
      InterpretedAsImprovement M
  )

end SigmaR
end SigmaR
