import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Regime_Legitimacy.ExitRegime.ExitPreservation_Justification
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
axiom exit_denial_generates_dominant_coupling :
  ∀ {F : Operation},
    ¬ ExitViabilityMonotone F →
    DominantCoupling F

theorem exit_denial_implies_dominant_coupling
  {F : Operation}
  (hExitFail : ¬ ExitViabilityMonotone F) :
  DominantCoupling F :=
exit_denial_generates_dominant_coupling hExitFail

end SigmaR
