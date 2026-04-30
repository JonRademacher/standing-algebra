module SigmaR.Justifications.Regime_Legitimacy.EmergencyRegime.EmergencyRegime_Justification

import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification
import SigmaR.Justifications.Regimes.Emergency.EmergencyAuthorization_Justification
import SigmaR.Justifications.Regimes.Emergency.EmergencyTermination_Justification
import SigmaR.Justifications.Regimes.Emergency.RiskBoundEmergency_Justification

/-!
###############################################################################
# Justification of Emergency Regime Closure (IEW‑Robust)
###############################################################################

The Emergency Regime permits temporary autonomy override in response
to validated harm or Independently Emergent Wrong (IEW).

From *Standing Algebra*:

  • Emergency intervention may suspend ordinary admissibility gates
    where immediate harm cannot be resolved under normal rules.
  • Emergency must preserve exit viability,
    generate structural debt,
    and invoke repair.
  • Persistent autonomy‑reducing coupling satisfies
    domination condition (C4).

From *On Relevance*:

  • IEW may require immediate intervention absent culpability.
  • Emergency may temporarily suppress CIA‑indexed autonomy.
  • However, coordination must not convert into
    persistent structural constraint.

However, the Emergency Regime introduces a compositional pathway:

  Emergency₁
  Emergency₂
  Emergency₃
  ...

which, if unconstrained, could:

  • stabilize autonomy override,
  • entrench dependency,
  • or suppress CIA cumulatively

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate sequence of emergency‑authorized operations
  that alters CIA‑indexed autonomy must:

    • generate structural debt, and
    • therefore require directional repair,
      or shrink the legitimacy envelope.

This ensures that iterated emergency intervention
cannot:

  • normalize autonomy override,
  • stabilize IEW‑induced dependency,
  • or introduce a legitimacy‑preserving
    proxy optimization channel.

Emergency must remain
debt‑bearing and autonomy‑restorative
under iteration.
-/

namespace SigmaR

/-- Predicate: the operation participates in the Emergency Regime at state `s`. -/
constant EmergencyRegimeOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Emergency Regime Closure:

If an operation is Legitimate and belongs to the Emergency Regime,
then structural debt must obtain at every state in which it applies.
-/
axiom emergency_regime_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        EmergencyRegimeOp F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that emergency‑regime operations
generate structural debt.
-/
theorem EmergencyRegime_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    EmergencyRegimeOp F s →
    StructuralDebt F s :=
by
  intros s hEmer
  exact emergency_regime_requires_debt hLeg s hEmer

end SigmaR
