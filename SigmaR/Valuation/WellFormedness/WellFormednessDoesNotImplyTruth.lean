import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formedness Does Not Imply Truth
###############################################################################

Structural well-formedness does not imply truth,
correctness, or correspondence with reality.

Truth is not a structural property.
###############################################################################
-/

namespace SigmaR.Valuation.WellFormedness

/--
No implication from well-formedness to truth is permitted.
-/
axiom wellformedness_not_truth :
  ¬ (
    ∀ (M : SigmaR.Valuation.Core.Measure),
      SigmaR.Valuation.Core.WellFormed M →
        SigmaR.Valuation.Core.TrueMeasure M
  )

end SigmaR.Valuation.WellFormedness
