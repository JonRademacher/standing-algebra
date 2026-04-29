import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# PFA Does Not Imply Legitimacy
###############################################################################

Perceptual Frame Agreement does not confer authority,
legitimacy, or justification for action or policy.
###############################################################################
-/

namespace SigmaR

/--
No implication from PFA to legitimacy, authority,
or justificatory warrant is permitted.
-/
axiom pfa_not_legitimacy :
  ¬ (
    ∀ (G : Set Agent) (s : State),
      PFA G s →
      LegitimateMeasure (fun _ _ => 0)
  )

end SigmaR
