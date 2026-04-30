module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorAvailability_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Availability Justification
###############################################################################

Standing Algebra enforces pluralistic inclusion.

From Standing Algebra and On Relevance:

  • No agent may remain a permanent nullity.
  • For every agent, there must exist a path
    from σ = 0 to σ = S(0).
  • Denial of the first successor increment
    is structural exclusion.

Therefore:

  Successor availability is required
  for legitimacy.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` has an available successor path
under operation `F` at state `s`.
-/
constant SuccessorAvailable : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor Availability):

If an agent has null standing, legitimacy requires
that a successor path be available.
-/
axiom successor_availability_required :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      ∀ a : Agent,
        σ s a = 0 →
        SuccessorAvailable a F s

/--
Derived theorem:

Legitimate systems provide successor access.
-/
theorem SuccessorAvailableForNull
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ∀ a : Agent,
      σ s a = 0 →
      SuccessorAvailable a F s :=
by
  intros s a hNull
  exact successor_availability_required hLeg s a hNull

end SigmaR
``
