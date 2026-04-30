module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.ContinuationLegitimacyStability_Justification

import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification

/-!
###############################################################################
# Continuation Legitimacy Stability Justification
###############################################################################

Standing Algebra is plural and non-teleological.

From Standing Algebra and On Relevance:

  • Legitimacy does not require convergence
    or stable outcomes.
  • However, legitimacy must remain satisfiable
    under continuation.
  • Successor structures that force all sufficiently
    extended continuations into illegitimacy
    constitute deferred domination.

This is a stability condition on constraints,
not on trajectories.

Therefore:

  Legitimate successor structures must preserve
  the satisfiability of legitimacy under continuation.
###############################################################################
-/

namespace SigmaR

/--
Predicate: continuation paths from operation `F`
remain legitimacy-satisfiable beyond state `s`.
-/
constant LegitimacySatisfiableBeyond : Operation → State → Prop

/--
Tier-2 legitimacy axiom (Continuation Legitimacy Stability):

A legitimate successor operation may not force
all future continuations into illegitimacy.

There must remain at least one continuation
that preserves legitimacy satisfiability.
-/
axiom continuation_legitimacy_stable :
  ∀ {F : Operation},
    SuccessorRegimeOp F →
    ∀ s : State,
      LegitimacySatisfiableBeyond F s

/--
Derived theorem:

Successor legitimacy is stable under continuation.
-/
theorem ContinuationLegitimacyStable
  {F : Operation}
  (hSucc : SuccessorRegimeOp F) :
  ∀ s : State,
    LegitimacySatisfiableBeyond F s :=
by
  intro s
  exact continuation_legitimacy_stable hSucc s

end SigmaR
