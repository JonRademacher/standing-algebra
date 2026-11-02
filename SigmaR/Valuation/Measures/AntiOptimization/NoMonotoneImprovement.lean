import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# No Monotone Improvement
###############################################################################

Monotonicity does not imply improvement, benefit,
or desirability.

A value may evolve monotonically without becoming "better".
###############################################################################
-/

namespace SigmaR.Valuation.Measures.AntiOptimization

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

end SigmaR.Valuation.Measures.AntiOptimization
