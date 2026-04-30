module SigmaR.Justifications.Core_Legitimacy.NRPP_Justification

import SigmaR.StandingAlgebra_RegimeStacked
import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of the Non‑Retributive Proportionality Principle (NRPP)
###############################################################################

From *On Relevance*:

• “NRPP: The requirement that any response be the least autonomy‑reducing
  means sufficient to neutralize validated harm.” (§3.4.5)

• “By the stripping of autonomy of others, offenders incur a sacrifice of the
  proportional level of their own autonomy … This is the Non‑Retributive
  Proportionality Principle (NRPP).” (p. 1494)

NRPP is gate (3) of the Standing‑to‑Coerce Test (STC‑5). It does not authorize
coercion; it bounds it. Any legitimate coercive operation must already satisfy
NRPP, or legitimacy collapses into retributive domination.

This file extracts NRPP as a necessary condition of legitimacy.
-/

namespace SigmaR

/--
Any operation deemed `Legitimate` must satisfy the Non‑Retributive
Proportionality Principle (NRPP) in every state.

This theorem is the third gate of STC‑5 isolated as a standalone
necessity result.
-/
theorem NRPP_required_for_legitimacy
  {F : Operation}
  (hLegit : Legitimate F) :
  ∀ s : State, NRPP_Fit F s :=
by
  -- This follows directly from the STC‑5 justification:
  -- NRPP is gate (3) of the five‑gate legitimacy test.
  exact legit_implies_nrpp hLegit

end SigmaR
