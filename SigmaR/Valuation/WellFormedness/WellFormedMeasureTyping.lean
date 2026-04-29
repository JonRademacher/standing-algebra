import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Measure Typing
###############################################################################

Valuation measures must be structurally admitted as measures.

This file prevents predicates, actions, or arbitrary
Nat-valued functions from being treated as valuation
measures merely because their type matches.
###############################################################################
-/

namespace SigmaR

/--
Having the correct function type is not sufficient
to be a valuation measure.
-/
axiom no_typing_only_measure_admission :
  ¬ (
    ∀ (M : Agent → State → Nat),
      IsMeasure M
  )

/--
Predicates may not be treated as valuation measures.
-/
axiom no_predicate_as_measure :
  ¬ (
    ∀ (P : Agent → State → Prop),
      IsMeasure (fun a s => if P a s then 1 else 0)
  )

end SigmaR

