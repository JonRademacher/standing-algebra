import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Definition Neutrality
###############################################################################

Valuation definitions must be semantically neutral.

They must not encode moral judgments, policy decisions,
optimization goals, or normative classifications.

Any evaluative or policy-driven semantics must be introduced
in higher layers or explicit models.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
No implication from the mere existence of a valuation
definition to normative, policy, or evaluative interpretation
is permitted.
-/
axiom definition_neutrality :
  ¬ (
    ∀ (M : Measure),
      IsMeasure M →
      (TreatedAsUtility M ∨
       TreatedAsWelfare M ∨
       InterpretedAsImprovement M)
  )

end SigmaR.Valuation.Measures.Definitions
