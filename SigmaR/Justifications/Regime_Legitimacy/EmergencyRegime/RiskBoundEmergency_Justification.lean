module SigmaR.Justifications.Regime_Legitimacy.EmergencyRegime.RiskBoundEmergency_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Risk‑Bound Emergency
###############################################################################

The Emergency Regime permits temporary autonomy override in response
to validated harm threatening standing or exit viability.

From *Standing Algebra*:

  • Emergency intervention must remain risk‑sensitive.
  • Risk‑bearers must inherit intervention burden.
  • Coercion that burdens agents must preserve exit viability
    and generate repair obligations.

From *On Relevance*:

  • Emergency intervention must be authorized by those
    who bear the relevant risk.
  • IEW‑responsive intervention may temporarily suppress
    CIA‑indexed autonomy.
  • However, burden transfer without repair stabilizes
    structural injustice.

Risk‑Bound Emergency therefore introduces an autonomy‑altering pathway:

  Emergency₁
  Emergency₂
  Emergency₃
  ...

which, if unconstrained, could:

  • suppress CIA asymmetrically,
  • stabilize dependency among high‑risk agents,
  • or entrench autonomy override

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate risk‑weighted emergency operation
  that alters CIA‑indexed autonomy must incur
  structural debt and therefore require
  directional repair.

This ensures that risk‑bound emergency cannot
introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation performs risk‑weighted emergency intervention at state `s`. -/
constant RiskBoundEmergency : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk‑Bound Emergency:

If an operation is Legitimate and performs
risk‑weighted emergency intervention
that alters CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom risk_bound_emergency_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskBoundEmergency F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that risk‑bound emergency
operations generate structural debt.
-/
theorem RiskBoundEmergency_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskBoundEmergency F s →
    StructuralDebt F s :=
by
  intros s hEmerg
  exact risk_bound_emergency_requires_debt hLeg s hEmerg

end SigmaR
