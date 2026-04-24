import SigmaR.Operations.LegitimacyInterface
import SigmaR.Justifications.Regimes.Emergency.EmergencyRegime_Justification
import SigmaR.Justifications.Regimes.Emergency.EmergencyContraction_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification

/-!
###############################################################################
# Illegitimacy of Emergency Without Contraction
###############################################################################

Emergency authorization is not closure-stable under Σᴿ.

If an operation participates in the Emergency Regime and accumulates
structural debt but fails to contract or repair that debt, then
legitimacy collapses.

This theorem demonstrates that emergency intervention cannot be
normalized or stabilized.
###############################################################################
-/

namespace SigmaR

/--
**Emergency without contraction is illegitimate.**

Emergency operations that accumulate structural debt but fail
to contract or repair that debt cannot be legitimate.
-/
theorem emergency_without_contraction_implies_illegitimacy
  {F : Operation} {s : State}
  (hEmer : EmergencyRegimeOp F s)
  (hDebt : StructuralDebt F s)
  (hNoContraction : ¬ EmergencyContraction F s) :
  ¬ Legitimate F :=
by
  intro hLeg

  -- Legitimate emergency operations must contract or repair debt.
  have hReq :
    EmergencyContraction F s :=
    EmergencyContraction_required_for_legitimacy hLeg hEmer hDebt

  exact hNoContraction hReq

end SigmaR
