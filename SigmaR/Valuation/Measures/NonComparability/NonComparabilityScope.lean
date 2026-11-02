import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

open SigmaR.Valuation.Core

/-!
###############################################################################
# Non-Comparability Scope
###############################################################################

Non-comparability applies only where explicitly declared.
It is not assumed globally, but must be respected
where asserted.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.NonComparability

/--
No implication permitting declared non-comparability
to be ignored, overridden, or bypassed by default
is allowed.
-/
axiom noncomparability_scope :
  ¬ (
    ∃ (C : NonComparabilityContext)
      (M₁ M₂ : Measure),
      IsMeasure M₁ ∧
      IsMeasure M₂ ∧
      NonComparableInContext C M₁ M₂ ∧
      ¬ NonComparable M₁ M₂
  )

end SigmaR.Valuation.Measures.NonComparability
