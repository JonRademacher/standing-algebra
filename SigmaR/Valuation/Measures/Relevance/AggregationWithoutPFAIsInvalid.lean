import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Aggregation Without PFA Triggers Re-Evaluation
###############################################################################

Aggregation based solely on individual perceptual frames
does not by itself establish collective warrant.

Such aggregation requires evaluation of non-parochial
evidence sufficient to justify relevance back to PFA.
###############################################################################
-/

namespace SigmaR

/--
Aggregation without PFA does not establish collective warrant
and triggers the need for non-parochial evaluation.
-/
axiom aggregation_without_pfa_requires_evaluation :
  ∀ (A : (Agent → State → Prop) → Prop),
    ¬ (A True) →
    ∃ (E : State → Prop),
      True

end SigmaR
