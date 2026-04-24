import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Regimes.ExitRegime.ExitPreservation_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification

/-!
###############################################################################
# Exit Denial Induces Dominant Coupling
###############################################################################

Exit viability is a core non-domination constraint in Σᴿ.

If an operation denies or destroys exit viability, it induces
a dominant coupling structure, violating legitimacy.
###############################################################################
-/

namespace SigmaR

/--
**Exit denial induces dominant coupling.**

Any operation that fails to preserve exit viability
creates a dominant coupling relation.
-/
theorem exit_denial_implies_dominant_coupling
  {F : Operation}
  (hExitFail : ¬ ExitViabilityMonotone F) :
  DominantCoupling F :=
by
  -- Exit denial is sufficient for dominance by justification.
  exact dominant_coupling_from_exit_denial hExitFail

end SigmaR
