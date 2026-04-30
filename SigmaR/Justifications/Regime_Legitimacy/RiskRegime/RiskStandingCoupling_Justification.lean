module SigmaR.Justifications.Regime_Legitimacy.RiskRegime.RiskStandingCoupling_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskRegime_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskInheritance_Justification

/-!
###############################################################################
# Risk–Standing Coupling Justification
###############################################################################

Standing Algebra treats risk as a standing-relevant structural burden.

From Standing Algebra:

  • Risk exposure constrains autonomy by increasing dependency
    and reducing exit feasibility.
  • Persistent or unmitigated risk cannot be standing-neutral.
  • Risk that does not reduce standing must be actively repaired.

From On Relevance:

  • Risk laundering through standing-neutral framing is a form
    of domination-by-stabilization.
  • Treating risk as harmless without repair collapses
    relevance-sensitive legitimacy.

Therefore:

  Any legitimate operation participating in the Risk Regime
  that introduces risk must either:

    • generate structural debt (standing-relevant burden), or
    • perform directed repair.

Risk may not be standing-neutral under legitimacy.
###############################################################################
-/

namespace SigmaR

/--
Predicate: the operation introduces risk that is standing-relevant
at state `s`.

This is intentionally abstract and non-quantitative.
-/
constant StandingRelevantRisk : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Risk–Standing Coupling):

If an operation is Legitimate, participates in the Risk Regime,
and introduces standing-relevant risk, then either:

  • structural debt must obtain, or
  • directed repair must occur.

Risk cannot be standing-neutral under legitimacy.
-/
axiom risk_standing_coupling_required :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RiskRegimeOp F s →
        StandingRelevantRisk F s →
        (StructuralDebt F s ∨ DirectedRepair F s)

/--
Derived theorem:

Legitimate risk-regime operations must acknowledge
standing impact or perform repair.
-/
theorem RiskStandingCouplingRequired
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RiskRegimeOp F s →
    StandingRelevantRisk F s →
    (StructuralDebt F s ∨ DirectedRepair F s) :=
by
  intros s hRisk hSR
  exact risk_standing_coupling_required hLeg s hRisk hSR

end SigmaR
