import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.AntiOptimization.AntiOptimizationContract

/-!
###############################################################################
# AntiOptimization Does Not Imply Inaction
###############################################################################

The absence of optimization assumptions does not imply
that action, intervention, or response is impossible.

AntiOptimization restricts goals and teleology,
not the possibility of action.
###############################################################################
-/

namespace SigmaR

/-- Marker predicate for permissible actions/interventions.
    (Defined elsewhere; only referenced structurally here.) -/
constant ActionPossible : State → State → Prop

/--
No implication from the absence of optimization
to the impossibility of action is permitted.
-/
axiom antioptimization_not_inaction :
  ¬ (
    ¬ (∃ (O : Obj), Optimizes O) →
    ¬ (∃ (s₁ s₂ : State), ActionPossible s₁ s₂)
  )

end SigmaR
