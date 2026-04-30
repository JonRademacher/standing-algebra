module SigmaR.Justifications.Regime_Legitimacy.Affordance_CompositionRegime.StandingMonotonicityUnderComposition_Justification

import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Standing Monotonicity Under Affordance Composition Justification
###############################################################################

Standing Algebra enforces monotonicity of standing
as a core non-domination constraint (ALRP).

From Standing Algebra and On Relevance:

  • Legitimate operations may not reduce standing.
  • Preserving standing at each step is insufficient
    if standing erodes under composition.
  • Gradual standing loss via locally admissible
    affordances constitutes domination by attrition.

Therefore:

  Standing monotonicity must hold globally
  under affordance composition.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` is a composition of affordance operations.
-/
constant AffordanceComposed : Operation → Prop

/--
Predicate: operation `F` preserves standing
for agent `a` at state `s`.
-/
constant PreservesStanding : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Standing Monotonicity Under Composition):

If each component affordance preserves standing
for an agent, then their composition must also
preserve standing for that agent.

Standing may not erode by composition.
-/
axiom standing_monotone_under_composition :
  ∀ {G : Operation},
    AffordanceComposed G →
    ∀ a : Agent,
      (∀ F : Operation,
         ComponentOf F G →
         ∀ s : State,
           PreservesStanding a F s) →
      ∀ s : State,
        PreservesStanding a G s

/--
Derived theorem:

Affordance composition preserves standing.
-/
theorem StandingMonotonicityUnderComposition
  {G : Operation}
  (hComp : AffordanceComposed G) :
  ∀ a : Agent,
    (∀ F : Operation,
       ComponentOf F G →
       ∀ s : State,
         PreservesStanding a F s) →
    ∀ s : State,
      PreservesStanding a G s :=
by
  intros a hEach s
  exact standing_monotone_under_composition hComp a hEach s

end SigmaR
