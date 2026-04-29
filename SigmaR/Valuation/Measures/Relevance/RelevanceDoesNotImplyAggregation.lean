import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

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
No implication permitting relevance (IPFA) to authorize
aggregation without PFA is allowed.
-/
axiom relevance_not_aggregation :
  ¬ (
    ∃ (G : Set Agent) (s : State) (O : Obj),
      (∀ a ∈ G, IPFA a s) ∧      -- relevance present
      ¬ PFA G s ∧               -- no collective warrant
      AggregatesFromMeasure O (fun _ _ => 0)
  )

end SigmaR

