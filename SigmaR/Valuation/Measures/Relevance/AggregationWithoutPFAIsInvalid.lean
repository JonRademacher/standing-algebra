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
No implication permitting aggregation without PFA
to establish collective warrant or relevance is allowed.
-/
axiom aggregation_without_pfa_requires_evaluation :
  ¬ (
    ∃ (G : Set Agent) (s : State),
      ¬ PFA G s ∧
      TreatedAsAuthoritative s
  )

end SigmaR
