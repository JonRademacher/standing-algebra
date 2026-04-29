import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# No Scalarization
###############################################################################

Distinct valuation dimensions must not be collapsed into
a single scalar quantity by default.
###############################################################################
-/

namespace SigmaR

/--
No implication permitting scalar collapse of multiple
valuation measures is allowed.
-/
axiom no_scalarization :
  ¬ (
    ∃ (Ms : Set Measure) (O : Obj),
      (∃ M₁ M₂, M₁ ∈ Ms ∧ M₂ ∈ Ms ∧ M₁ ≠ M₂) ∧
      Scalarizes Ms O
  )

end SigmaR
