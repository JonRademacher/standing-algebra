import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification

/-!
###############################################################################
# Dominant Coupling Implies Illegitimacy
###############################################################################

Dominant coupling is incompatible with legitimacy under Σᴿ.

This file provides the explicit corollary that any operation inducing
dominant coupling cannot be legitimate.
###############################################################################
-/

namespace SigmaR

/--
**Dominant coupling is illegitimate.**

Any operation that induces a dominant coupling relation
cannot satisfy the Σᴿ legitimacy constraints.
-/
theorem dominant_coupling_implies_illegitimacy
  {F : Operation}
  (hDom : DominantCoupling F) :
  ¬ Legitimate F :=
by
  intro hLeg

  -- Legitimate operations exclude dominant coupling.
  have hNoDom :
    ¬ DominantCoupling F :=
    legitimacy_excludes_dominant_coupling hLeg

  exact hNoDom hDom

end SigmaR
