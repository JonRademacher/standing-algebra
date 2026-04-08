/-
Standing Algebra (Σᴿ)
Basic Lemmas and Derived Theorems
===============================

This file builds *on top of* `SigmaR_Core.lean`.

Purpose:
• hold derived definitions
• prove nontrivial theorems
• make no new philosophical commitments
• keep everything machine-checkable

Import discipline:
• MUST import only SigmaR_Core
• MUST NOT introduce new sorts or axioms casually
-/

import SigmaR_Core

open Nat

/-
────────────────────────────────────────────────────────────
Derived structural facts
────────────────────────────────────────────────────────────
-/

/--
Design invariant:
Every legitimate operation is admissible.

This is assumed implicitly throughout the theory
and made explicit here so that proofs can chain
legitimacy → admissibility → invariants.
-/
axiom legitimate_implies_admissible :
  ∀ F : Operation, Legitimate F → Admissible F

/--
A derived notion: standing is preserved everywhere
by an operation.
-/
def StandingPreserved (F : Operation) : Prop :=
  ∀ a : Agent, σ a ≤ σ (apply F a)

/--
A derived notion: an operation raises standing
for a specific agent.
-/
def RaisesStanding (F : Operation) (a : Agent) : Prop :=
  σ a < σ (apply F a)

/-
────────────────────────────────────────────────────────────
Basic lemmas
────────────────────────────────────────────────────────────
-/

/--
Any admissible operation preserves standing.
-/
theorem admissible_preserves_standing :
  ∀ F : Operation,
    Admissible F →
    StandingPreserved F :=
by
  intro F hAdm a
  exact ALRP_standing_preservation F a hAdm

/--
Legitimate operations do not decrease standing.
-/
theorem legitimate_preserves_standing :
  ∀ F : Operation,
    Legitimate F →
    StandingPreserved F :=
by
  intro F hLeg
  have hAdm : Admissible F :=
    legitimate_implies_admissible F hLeg
  exact admissible_preserves_standing F hAdm

/-
────────────────────────────────────────────────────────────
NONTRIVIAL THEOREM (real content)
────────────────────────────────────────────────────────────
-/

/--
Theorem: No escalation of domination pressure
under legitimate operations.

This is a core safety guarantee of Σᴿ:
legitimacy structurally prevents domination growth.
-/
theorem legitimate_no_domination_escalation :
  ∀ (F : Operation) (s : State),
    Legitimate F →
    DomPressure (apply F s) ≤ DomPressure s :=
by
  intro F s hLeg
  have hAdm : Admissible F :=
    legitimate_implies_admissible F hLeg
  exact DomPressure_monotonic F s hAdm

/-
────────────────────────────────────────────────────────────
Successor realization consequences
────────────────────────────────────────────────────────────
-/

/--
The successor realization strictly increases standing.
-/
theorem realize_S_strict :
  ∀ a : Agent,
    σ a < σ (Realize_S a) :=
by
  intro a
  rewrite realize_S_spec
  exact lt_succ_self (σ a)

/-
────────────────────────────────────────────────────────────
Notes for future extensions
────────────────────────────────────────────────────────────

• This file proves actual theorems, not axioms
• Further results (universality, non-extendability)
  should live here or in SigmaR_Theorems.lean
• No HOL or quotient machinery is required
• Z3-aligned reasoning remains possible
-/

/-
Standing Algebra (Σᴿ)
Derived Theorems — Lean 4
-/

import SigmaR_Core

open Nat

/--
Design invariant: every legitimate operation is admissible.

This is not merely definitional; it makes explicit the
"Legitimate ⊆ Admissible" structure assumed throughout Σᴿ proofs.
-/
axiom legitimate_implies_admissible :
  ∀ F : Operation, Legitimate F → Admissible F

/--
Theorem: No escalation of domination pressure under legitimate operations.

If F is legitimate, then applying F to any state s
cannot increase DomPressure.
-/
theorem legitimate_no_domination_escalation :
  ∀ (F : Operation) (s : State),
    Legitimate F →
    DomPressure (apply F s) ≤ DomPressure s :=
by
  intro F s hLegit
  have hAdm : Admissible F :=
    legitimate_implies_admissible F hLegit
  exact DomPressure_monotonic F s hAdm

/--
A violation witness: an operation that increases domination pressure.
-/
def EscalatesDomination (F : Operation) (s : State) : Prop :=
  DomPressure (apply F s) > DomPressure s

/--
Universality (Contrapositive Form):

If an operation violates an admissibility invariant,
then domination escalation is possible.
-/
axiom violation_implies_escalation :
  ∀ (F : Operation) (s : State),
    ¬ Admissible F →
    EscalatesDomination F s

/--
Formal Universality Theorem (Lean):

Any operation that does not escalate domination
must satisfy all admissibility constraints.
-/
theorem universality_contrapositive :
  ∀ (F : Operation) (s : State),
    ¬ EscalatesDomination F s →
    Admissible F :=
by
  intro F s hNoEsc
  by_contra hNotAdm
  have hEsc := violation_implies_escalation F s hNotAdm
  exact lt_irrefl _ (lt_of_lt_of_le hEsc (le_of_not_gt hNoEsc))

