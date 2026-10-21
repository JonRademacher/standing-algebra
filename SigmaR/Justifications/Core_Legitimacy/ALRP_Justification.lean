import SigmaR.StandingAlgebra_RegimeStacked

/-!
###############################################################################
# Justification of the Autonomy‑Limiting Reflex Principle (ALRP)
###############################################################################

This file provides a *necessity justification* for the ALRP, grounded in the
operational conception of legitimacy articulated in *On Relevance*.

The core idea is the Maxim of Mutual Autonomy (MOMA):

  "Any authority capable of binding others must be capable of binding itself
   under the same autonomy conditions."

In the algebraic language of Σᴿ, legitimacy is defined by a bundle of
non‑domination constraints (STC‑5 symmetry, NRPP, exit viability, bounded drift,
rerunnability, directed repair, risk inheritance, etc.).

If an operation satisfying those constraints were allowed to *reduce* the
standing of any agent, then the system’s domination‑pressure invariant would
increase — contradicting the very definition of legitimacy.

Thus ALRP is not an optional moral axiom: it is *forced* by nondomination.

This file formalizes that argument.
-/

namespace SigmaR

------------------------------------------------------------------------
-- Assumed core objects (already present in your development)
------------------------------------------------------------------------
-- Agent       : Type
-- State       : Type
-- Operation   : Type
-- σ           : Agent → Nat             (standing function; `State` and
--                                        `Agent` are the same carrier)
-- apply       : Operation → Agent → Agent
-- Legitimate  : Operation → Prop
-- DomPressure : State → Nat

------------------------------------------------------------------------
-- Justification‑layer axioms (operational, not normative)
------------------------------------------------------------------------

/-- Nondomination invariant:
    A legitimate operation cannot increase domination pressure. -/
axiom nondomination :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    DomPressure (apply F s) ≤ DomPressure s

/-- Structural monotonicity of domination pressure:
    If an agent’s standing strictly decreases, domination pressure strictly
    increases.

    This reflects the fact that DomPressure is a monotone aggregator of the
    σ‑profile (as discussed in *On Relevance*, §6). -/
axiom dp_increase_for_sigma_decrease :
  ∀ {F : Operation} {s : State},
    σ (apply F s) < σ s →
    DomPressure (apply F s) > DomPressure s

------------------------------------------------------------------------
-- ALRP as a derived necessity
------------------------------------------------------------------------

/-- **ALRP is required for legitimacy**.

If an operation is legitimate, then it cannot reduce the standing of any agent.
Allowing such a reduction would contradict the nondomination invariant.

This is the formal counterpart of the Maxim of Mutual Autonomy. -/
theorem ALRP_required_for_legitimacy
  {F : Operation} {s : State} (hLegit : Legitimate F) :
  σ (apply F s) ≥ σ s :=
by
  -- Split on whether standing decreases; a decrease is contradictory.
  cases Nat.lt_or_ge (σ (apply F s)) (σ s) with
  | inl h_lt =>
    -- A decrease in σ forces an increase in domination pressure …
    have h_dp_inc :
      DomPressure (apply F s) > DomPressure s :=
      dp_increase_for_sigma_decrease h_lt
    -- … but legitimacy forbids any increase in domination pressure.
    have h_dp_noninc :
      DomPressure (apply F s) ≤ DomPressure s :=
      nondomination hLegit
    -- Contradiction: pressure cannot both strictly increase and not increase.
    exact absurd (Nat.lt_of_lt_of_le h_dp_inc h_dp_noninc) (Nat.lt_irrefl _)
  | inr h_ge => exact h_ge

end SigmaR
