module SigmaR.Justifications.Regime_Legitimacy.RemedyRegime.RemedyNonEscalation_Justification

import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification

/-!
###############################################################################
# Remedy Non-Escalation Justification
###############################################################################

Remedy in Σᴿ must be minimal and harm-focused.

From Standing Algebra:

  • Repair exists to reduce standing-relevant harm.
  • Repair that introduces new harm or expands coercive scope
    violates proportionality.
  • Escalatory repair reintroduces domination.

Therefore:

  Legitimate remedy operations must not introduce
  new standing-relevant harm.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` introduces new standing-relevant harm
distinct from the harm it is intended to repair.
-/
constant RemedyEscalates : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Remedy Non-Escalation):

If an operation is Legitimate and participates in the Remedy Regime,
then it must not escalate harm.
-/
axiom remedy_non_escalating :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RemedyRegimeOp F s →
        ¬ RemedyEscalates F s

/--
Derived theorem:

Legitimate remedy does not escalate harm.
-/
theorem RemedyNonEscalating
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RemedyRegimeOp F s →
    ¬ RemedyEscalates F s :=
by
  intros s hRem
  exact remedy_non_escalating hLeg s hRem

end SigmaR
