import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Non-Triviality
###############################################################################

Well-formed valuation constructions must not be
structurally trivial.

This file prevents argument-insensitive or
structurally constant functions from being treated
as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
No structurally trivial valuation may be treated as a measure.

In particular, functions that ignore both Agent and State
are not admissible as valuation measures.
-/
axiom no_structurally_trivial_measure :
  ¬ (
    ∀ (M : Agent → State → Nat),
      StructurallyConstant M →
      IsMeasure M
  )

end SigmaR
