module SigmaR.Justifications.Regime_Legitimacy.Affordance_CompositionRegime.SymmetricalAffordanceExposure_Justification

import SigmaR.Justifications.Core_Legitimacy.STC5_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Symmetric Affordance Exposure Justification
###############################################################################

Standing Algebra requires symmetry of exposure
for agents of equal standing and capacity.

From Standing Algebra:

  • Symmetry applies to option space, not just actions.
  • Even if local affordances are symmetric,
    composition may introduce asymmetry.
  • Asymmetric affordance exposure constitutes domination.

Therefore:

  Affordance composition must preserve
  symmetric exposure to options.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` is exposed to affordance `F`
at state `s`.
-/
constant ExposedTo : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Symmetric Affordance Exposure):

If two agents have equal standing and capacity,
then affordance composition must expose them
to symmetric option sets.
-/
axiom symmetric_exposure_under_composition :
  ∀ {G : Operation} {a b : Agent},
    AffordanceComposed G →
    EqualStandingAndCapacity a b →
    ∀ s : State,
      ExposedTo a G s ↔ ExposedTo b G s

/--
Derived theorem:

Affordance composition preserves symmetric exposure.
-/
theorem SymmetricAffordanceExposure
  {G : Operation} {a b : Agent}
  (hComp : AffordanceComposed G)
  (hEq : EqualStandingAndCapacity a b) :
  ∀ s : State,
    ExposedTo a G s ↔ ExposedTo b G s :=
by
  intro s
  exact symmetric_exposure_under_composition hComp hEq s

end SigmaR
