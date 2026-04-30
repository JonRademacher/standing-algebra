module SigmaR.Justifications.Regime_Legitimacy.RiskRegime.RiskDiscountingProhibition_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskRegime_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskLoadMonotonicity_Justification

/-!
###############################################################################
# Risk Discounting Prohibition Justification
###############################################################################

Standing Algebra treats risk as a structural burden, not a scalar
optimization term.

From Standing Algebra:

  • Risk participates in legitimacy whenever it is non-zero.
  • Declaring risk "acceptable", "minimal", or "negligible" does not
    remove its standing relevance.
  • Legitimacy cannot be preserved by semantic reclassification of risk.

From On Relevance:

  • Risk laundering through re-description is a form of domination.
  • Discounting risk without repair, consent, or elimination
    collapses autonomy-preserving justification.

Therefore:

  Any legitimate operation participating in the Risk Regime
  that introduces risk may not preserve legitimacy
  by merely discounting or nullifying that risk categorically.

Risk must be:
  • repaired,
  • consented to (if modeled),
  • or structurally eliminated.

Otherwise, legitimacy fails.
###############################################################################
-/


namespace SigmaR

/--
Predicate: the operation introduces non-zero risk at state `s`.

This is intentionally abstract; no quantitative notion of risk
is assumed at this layer.
-/
constant IntroducesRisk : Operation → State → Prop

/--
Predicate: the operation declares introduced risk negligible,
acceptable, or legitimacy-neutral at state `s`.
-/
constant RiskDiscounted : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Risk Discounting Prohibition):

If an operation is Legitimate, participates in the Risk Regime,
and introduces risk, then that risk may not be rendered
legitimacy-neutral by discounting alone.
-/
axiom risk_discounting_prohibited :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskRegimeOp F s →
        IntroducesRisk F s →
        ¬ RiskDiscounted F s

/--
Derived theorem:

Legitimate risk-regime operations cannot preserve legitimacy
by categorically discounting introduced risk.
-/
theorem RiskDiscountingProhibited
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskRegimeOp F s →
    IntroducesRisk F s →
    ¬ RiskDiscounted F s :=
by
  intros s hRisk hIntro
  exact risk_discounting_prohibited hLeg s hRisk hIntro

end SigmaR
