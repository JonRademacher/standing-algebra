import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Regimes.RiskRegime.RiskRegime_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitPreservation_Justification

/-!
###############################################################################
# Illegitimacy of Risk + Exit Interaction
###############################################################################

Risk-bearing operations require preserved exit viability.

If an operation introduces risk while destroying or failing to preserve
exit viability, then legitimacy collapses.
###############################################################################
-/

namespace SigmaR

/--
**Risk combined with exit denial is illegitimate.**

Operations that introduce risk while denying exit
cannot be legitimate under Σᴿ.
-/
theorem risk_with_exit_denial_implies_illegitimacy
  {F : Operation} {s : State}
  (hRisk : RiskRegimeOp F s)
  (hIntro : IntroducesRisk F s)
  (hExitFail : ¬ ExitViabilityMonotone F) :
  ¬ Legitimate F :=
by
  intro hLeg

  -- Legitimate operations preserve exit viability.
  have hExit :
    ExitViabilityMonotone F :=
    legitimacy_preserves_exit_viability hLeg

  exact hExitFail hExit

end SigmaR
