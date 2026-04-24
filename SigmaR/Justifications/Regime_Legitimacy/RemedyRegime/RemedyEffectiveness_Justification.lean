import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification

/-!
###############################################################################
# Remedy Effectiveness Justification
###############################################################################

In Σᴿ, repair is not symbolic.

From Standing Algebra and On Relevance:

  • Repair is required in response to standing-relevant harm.
  • Repair that does not reduce that harm is functionally inert.
  • Cosmetic or expressive actions do not satisfy repair obligations.

Therefore:

  Legitimate remedy operations must be effective with respect to
  the harm that triggered repair.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` produces a measurable reduction
in the standing-relevant harm at state `s`.
-/
constant RemedyEffective : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Remedy Effectiveness):

If an operation is Legitimate and participates in the Remedy Regime,
then it must be an effective repair.
-/
axiom remedy_must_be_effective :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RemedyRegimeOp F s →
        RemedyEffective F s

/--
Derived theorem:

Legitimate remedy must be effective.
-/
theorem RemedyEffectiveRequired
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RemedyRegimeOp F s →
    RemedyEffective F s :=
by
  intros s hRem
  exact remedy_must_be_effective hLeg s hRem

end SigmaR
