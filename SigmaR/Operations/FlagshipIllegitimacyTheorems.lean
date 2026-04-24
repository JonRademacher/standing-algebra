import SigmaR.Operations.LegitimacyInterface

/-!
###############################################################################
# Flagship Illegitimacy Theorems for Σᴿ
###############################################################################

This file contains the first non-trivial consequences of the Σᴿ
legitimacy interface.

These theorems demonstrate that the justification stack is sufficient
to rule out concrete illegitimate operational patterns, without any
appeal to concrete models or implementations.
###############################################################################
-/

namespace SigmaR

------------------------------------------------------------------------
-- Flagship Theorem: Risk Discounting Illegitimacy
------------------------------------------------------------------------

/--
**Risk discounting without repair is illegitimate.**

If an operation participates in the Risk Regime, introduces risk,
and attempts to preserve legitimacy by discounting that risk,
then the operation cannot be legitimate.

This theorem demonstrates that Σᴿ prohibits
semantic risk laundering.
-/
theorem risk_discounting_implies_illegitimacy
  {F : Operation} {s : State}
  (hRisk : RiskRegimeOp F s)
  (hIntro : IntroducesRisk F s)
  (hDisc : RiskDiscounted F s) :
  ¬ Legitimate F :=
by
  intro hLeg

  -- Legitimate operations may not discount introduced risk.
  have hNoDisc :
    ¬ RiskDiscounted F s :=
    legitimacy_prohibits_risk_discounting hLeg hRisk hIntro

  -- Contradiction.
  exact hNoDisc hDisc

end SigmaR
