import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

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

namespace SigmaR

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

end SigmaR
