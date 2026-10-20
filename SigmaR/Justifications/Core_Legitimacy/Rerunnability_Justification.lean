import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Justification of Rerunnability
###############################################################################

Rerunnability is a Tier‑2 structural legitimacy axiom of Standing Algebra
(Σᴿ, *Axiom 18 — Rerunnability*).

Intuitively:

• A legitimate transformation may be re‑applied.
• Re‑applying it produces no further structural change.
• Repeated application therefore cannot ratchet standing, dependency, or
  domination pressure upward.

Rerunnability defeats:

• successor ratcheting,
• slow accumulation of structural debt,
• and coercion by iteration.

Therefore any operation deemed Legitimate must be idempotent on
configurations.
###############################################################################
-/

namespace SigmaR

/--
Tier‑2 axiom (Axiom 18 — Rerunnability).

A legitimate operation is idempotent: rerunning it changes nothing further.
-/
axiom rerunnability :
  ∀ (F : Operation) (s : State),
    Legitimate F →
    apply F (apply F s) = apply F s

/--
Rerunnability, restated as a reusable rule.

This is the formal counterpart of the "no slow creep" argument in
*On Relevance* §6.
-/
theorem legitimate_is_rerunnable
  {F : Operation} (hLegit : Legitimate F) :
  ∀ s : State,
    apply F (apply F s) = apply F s :=
by
  intro s
  exact rerunnability F s hLegit

/--
Rerunnability blocks standing accumulation across reruns.

Applying a legitimate operation twice leaves standing where the first
application left it.
-/
theorem rerunnability_blocks_accumulation
  {F : Operation} (hLegit : Legitimate F) (s : State) :
  σ (apply F (apply F s)) = σ (apply F s) :=
by
  rw [rerunnability F s hLegit]

end SigmaR
