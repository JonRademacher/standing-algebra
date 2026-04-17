import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification

/-!
###############################################################################
# Justification of Emergency Authorization
###############################################################################

The Emergency Regime permits temporary autonomy override in response
to validated harm that threatens standing or exit viability.

From *Standing Algebra*:

  • Emergency intervention may suspend ordinary admissibility gates
    when immediate harm cannot be resolved under normal rules.
  • Such intervention must remain bounded, terminable,
    and subject to repair.

From *On Relevance*:

  • External correction is justified where validated harm
    outweighs autonomy cost.
  • IEW may require immediate intervention absent culpability.
  • Emergency must not create a new standing relation.

However, Emergency Authorization introduces an autonomy‑altering pathway:

  Emergency₁
  Emergency₂
  Emergency₃
  ...

which, if unconstrained, could:

  • suppress CIA‑indexed autonomy,
  • stabilize override,
  • or entrench dependency

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate emergency‑authorized operation
  that alters CIA‑indexed autonomy must incur
  structural debt and therefore require
  directional repair.

This ensures that emergency authorization
cannot introduce a legitimacy‑preserving
proxy optimization channel.
-/

namespace SigmaR

/-- Predicate: the operation is emergency‑authorized at state `s`. -/
constant EmergencyAuthorized : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Emergency Authorization:

If an operation is Legitimate and is authorized under
emergency conditions that alter CIA‑indexed autonomy,
then structural debt must obtain.
-/
axiom emergency_authorization_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        EmergencyAuthorized F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that emergency‑authorized operations
generate structural debt.
-/
theorem EmergencyAuthorization_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    EmergencyAuthorized F s →
    StructuralDebt F s :=
by
  intros s hEmerg
  exact emergency_authorization_requires_debt hLeg s hEmerg

end SigmaR
