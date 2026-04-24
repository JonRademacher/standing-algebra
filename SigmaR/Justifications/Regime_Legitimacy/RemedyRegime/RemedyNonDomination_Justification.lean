import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification

/-!
###############################################################################
# Remedy Non-Dominating Justification
###############################################################################

Repair in Σᴿ may not create new domination structures.

From Standing Algebra and On Relevance:

  • Repair exists to dismantle domination, not reconfigure it.
  • Repair that introduces new dependencies or control
    is structurally illegitimate.
  • Benevolent domination remains domination.

Therefore:

  Legitimate remedy operations must not induce
  dominant coupling.
###############################################################################
-/

namespace SigmaR

/--
Tier-2 legitimacy axiom (Remedy Non-Domination):

If an operation is Legitimate and participates in the Remedy Regime,
then it must not induce dominant coupling.
-/
axiom remedy_non_dominating :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        RemedyRegimeOp F s →
        ¬ DominantCoupling F

/--
Derived theorem:

Legitimate remedy does not dominate.
-/
theorem RemedyNonDominating
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    RemedyRegimeOp F s →
    ¬ DominantCoupling F :=
by
  intros s hRem
  exact remedy_non_dominating hLeg s hRem

end SigmaR
