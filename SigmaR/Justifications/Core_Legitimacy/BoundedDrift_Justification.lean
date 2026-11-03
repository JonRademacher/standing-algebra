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
  |σ (apply F s) − σ s| ≤ 1

`State` and `Agent` are the same carrier in the formal core, so the standing
`σ` of the evolving state carries the agent index implicitly.
-/
def DriftBounded (F : Operation) (s : State) : Prop :=
  (σ (apply F s) ≤ σ s + 1) ∧
  (σ s ≤ σ (apply F s) + 1)

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
    ∀ {s : State},
      DriftBounded F s

/--
Bounded Drift is required for legitimacy.

This theorem isolates bounded drift as a necessary condition for
legitimate coercion.
-/
theorem BoundedDrift_required_for_legitimacy
  {F : Operation}
  (hLegit : Legitimate F) :
  ∀ {s : State},
    DriftBounded F s :=
by
  intro s
  exact legit_implies_drift_bounded hLegit

end SigmaR
