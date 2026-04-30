module SigmaR.Justifications.Regime_Legitimacy.Affordance_CompositionRegime.ExitPreservationUnderComposition_Justification

import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitPreservation_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Exit Preservation Under Affordance Composition Justification
###############################################################################

Standing Algebra treats exit as a structural condition
for non-domination, not a local permission.

From Standing Algebra and On Relevance:

  • Exit must be meaningfully available to agents
    whose standing is constrained.
  • Preserving exit at each step is insufficient
    if the composition of affordances eliminates
    all viable exit paths.
  • Exit collapse may occur by gradual pruning,
    sequencing, or exhaustion, even when no
    individual affordance blocks exit.

Therefore:

  Exit preservation must hold globally under
  affordance composition, not merely locally.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` is a composition of affordance operations.
-/
constant AffordanceComposed : Operation → Prop

/--
Predicate: agent `a` has a viable exit under operation `F`
at state `s`.
-/
constant HasExit : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Exit Preservation Under Composition):

If each component affordance preserves exit for an agent,
then their composition must also preserve exit.

Exit may not collapse by composition.
-/
axiom exit_preserved_under_composition :
  ∀ {G : Operation},
    AffordanceComposed G →
    ∀ a : Agent,
      (∀ F : Operation,
         ComponentOf F G →
         ∀ s : State,
           HasExit a F s) →
      ∀ s : State,
        HasExit a G s

/--
Derived theorem:

Affordance composition preserves exit.
-/
theorem ExitPreservedUnderComposition
  {G : Operation}
  (hComp : AffordanceComposed G) :
  ∀ a : Agent,
    (∀ F : Operation,
       ComponentOf F G →
       ∀ s : State,
         HasExit a F s) →
    ∀ s : State,
      HasExit a G s :=
by
  intros a hEach s
  exact exit_preserved_under_composition hComp a hEach s

end SigmaR
