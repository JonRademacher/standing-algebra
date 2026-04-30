module SigmaR.Justifications.Regime_Legitimacy.RiskRegime.RiskRegime_Justification

import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.LegitimacyEnvelope_Justification
import SigmaR.Justifications.Regimes.Risk.RiskInheritance_Justification
import SigmaR.Justifications.Regimes.Risk.RiskSensitiveSymmetry_Justification
import SigmaR.Justifications.Regimes.Risk.RiskLoadMonotonicity_Justification

/-!
###############################################################################
# Justification of Risk Regime Closure (IEW‑Robust)
###############################################################################

The Risk Regime permits standing‑weighted intervention
based on autonomy‑relevant exposure.

From *Standing Algebra*:

  • RiskLoad tracks autonomy‑relevant burden.
  • Legitimate operations may not reduce
    structural exposure without Repair.
  • StructuralDebt must dissipate via Repair.
  • Infinite admissible trajectories must
    stabilize or invoke repair.

From *On Relevance*:

  • IEW may concentrate unevenly across agents.
  • Intervention may scale asymmetrically.
  • However, asymmetry must not stabilize
    into persistent standing loss.

However, the Risk Regime introduces a compositional pathway:

  RiskIntervene₁
  RiskIntervene₂
  RiskIntervene₃
  ...

which, if unconstrained, could:

  • suppress CIA asymmetrically,
  • stabilize reduced autonomy,
  • or entrench dependency structures

while preserving procedural legitimacy.

At the justification layer we therefore require:

  Any legitimate sequence of risk‑weighted
  operations that alters CIA‑indexed autonomy
  must:

    • generate structural debt, and
    • therefore require directional repair,
      or shrink the legitimacy envelope.

This ensures that iterated standing‑weighted
intervention cannot:

  • stabilize IEW‑induced autonomy loss,
  • normalize asymmetric CIA suppression,
  • or introduce a legitimacy‑preserving
    proxy optimization channel.

Risk‑weighted intervention must remain
debt‑bearing and autonomy‑restorative
under iteration.
-/

namespace SigmaR

/-- Predicate: the operation participates in the Risk Regime at state `s`. -/
constant RiskRegimeOp : Operation → State → Prop

/--
Tier‑2 legitimacy axiom for Risk Regime Closure:

If an operation is Legitimate and belongs to the Risk Regime,
then structural debt must obtain at every state in which it applies.
-/
axiom risk_regime_requires_debt :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskRegimeOp F s →
        StructuralDebt F s

/--
Derived theorem:

Legitimacy implies that risk‑regime operations
generate structural debt.
-/
theorem RiskRegime_requires_debt
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskRegimeOp F s →
    StructuralDebt F s :=
by
  intros s hRisk
  exact risk_regime_requires_debt hLeg s hRisk

end SigmaR
