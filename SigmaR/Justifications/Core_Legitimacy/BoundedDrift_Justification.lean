module SigmaR.Justifications.Core_Legitimacy.BoundedDrift_Justification

import SigmaR.StandingAlgebra_RegimeStacked

/-!
###############################################################################
# Justification of Bounded Drift
###############################################################################

Bounded Drift is a Tier‑2 legitimacy invariant appearing in both the formal
Standing Algebra (Σᴿ) and the prose of *On Relevance*.

Intuitively:
• Legitimate coercion may permit change,
• but it may not permit unbounded or shock‑like jumps in standing.
• Structural transformation must proceed within a “drift budget”.

Unbounded drift defeats:
• rerunnability,
• contestability,
• exit viability,
• and non‑domination.

Therefore any operation deemed Legitimate must obey bounded drift.
-/

namespace SigmaR

/-- 
Bounded drift predicate.

An operation F is drift‑bounded in state s for agent a if the change in
standing is at most one unit in either direction.

This encodes the absolute bound:
  |σ (apply F s) a − σ s a| ≤ 1
-/
def DriftBounded (F : Operation) (s : State) (a : Agent) : Prop :=
  (σ (apply F s) a ≤ σ s a + 1) ∧
  (σ s a ≤ σ (apply F s) a + 1)

/--
Tier‑2 legitimacy constraint:

Any operation that is Legitimate must obey bounded drift for every
state and every agent.

This summarizes the bounded‑drift clause of Standing Algebra
Theorem 6.13 and the “drift budget” argument in *On Relevance*.
-/
axiom legit_implies_drift_bounded :
  ∀ {F : Operation},
    Legitimate F →
    ∀ {s : State} {a : Agent},
      DriftBounded F s a

/--
Bounded Drift is required for legitimacy.

This theorem isolates bounded drift as a necessary condition for
legitimate coercion.
-/
theorem BoundedDrift_required_for_legitimacy
  {F : Operation}
  (hLegit : Legitimate F) :
  ∀ {s : State} {a : Agent},
    DriftBounded F s a :=
by
  intro s a
  exact legit_implies_drift_bounded hLegit

end SigmaR
