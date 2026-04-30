module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorNonDeprivation_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Successor Non-Deprivation Justification
###############################################################################

Domination may occur without standing reduction
by denying successor progression.

From Standing Algebra and On Relevance:

  • Blocking successor access is standing-relevant harm.
  • An agent may not be permanently frozen
    at a fixed standing level.
  • ALRP blocks reduction; this blocks deprivation.

Therefore:

  Legitimate systems may not deprive agents
  of successor access.
###############################################################################
-/

namespace SigmaR

/--
Predicate: agent `a` is deprived of successor access
under operation `F` at state `s`.
-/
constant SuccessorDeprived : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor Non-Deprivation):

Legitimate operations may not deprive agents
of successor access.
-/
axiom successor_non_deprivation_required :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      ∀ a : Agent,
        ¬ SuccessorDeprived a F s

/--
Derived theorem:

Legitimate systems do not deprive successor access.
-/
theorem SuccessorNonDeprived
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    ∀ a : Agent,
      ¬ SuccessorDeprived a F s :=
by
  intros s a
  exact successor_non_deprivation_required hLeg s a

end SigmaR
