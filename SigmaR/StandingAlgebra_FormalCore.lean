import Std

open Nat

/- -------------------------------------------------------------------------
   Sets

   Lean's core library has no `Set` type.  The Σᴿ layers are stated over
   *sets* of agents, measures, operations and options (`Set Agent`,
   `Set Measure`, …), so the notion is fixed once here as a predicate,
   together with the usual membership notation.
   ------------------------------------------------------------------------- -/

/--
A set is a predicate on its elements.
-/
abbrev Set (α : Type) : Type := α → Prop

instance instMembershipSet {α : Type} : Membership α (Set α) where
  mem s a := s a

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Formal Core (Lean 4)
   =========================================================

   This file contains ONLY the irreducible axiomatic core
   of Standing Algebra.

   • No state-level structure
   • No valuation deltas
   • No risk, repair, or legitimacy regimes
   • No coercion or emergency logic

   All later layers MUST import this file.
   This file MUST import no later layers.

   The purpose of this file is structural closure:
   every symbol introduced here is either primitive
   or provably coherent.
   ========================================================= -/

/- -----------------
   Primitive Sorts
   ----------------- -/

axiom Agent     : Type
axiom Operation : Type

/- -----------------
   Standing Structure
   ----------------- -/

axiom σ   : Agent → Nat        -- standing (autonomy-relevant)
axiom cap : Agent → Nat        -- capacity index
axiom B   : Nat → Nat          -- capacity-to-standing bound

/- -----------------
   Basic Extensionality
   ----------------- -/

/--
Standing respects agent equality.
This blocks pathological encodings where σ differs
on definitionally equal agents.
-/
axiom σ_ext :
  ∀ {a₁ a₂ : Agent}, a₁ = a₂ → σ a₁ = σ a₂

/- -----------------
   Configuration Carrier
   ----------------- -/

/--
Standing Algebra is stated over one carrier: an agent *is* a state of the
algebra, so `State` is the same type as `Agent` under another name.

This keeps the two levels of the signature — agent-indexed standing `σ` and
state-indexed pressure `DomPressure` — comparable without introducing a second
primitive sort.
-/
abbrev State : Type := Agent

/- -----------------
   Operations
   ----------------- -/

axiom apply : Operation → Agent → Agent

/--
Operation application respects agent equality.
This enforces functional extensionality of `apply`.
-/
axiom apply_ext :
  ∀ {F : Operation} {a₁ a₂ : Agent},
    a₁ = a₂ → apply F a₁ = apply F a₂

/--
State-level application of an operation.

`State` and `Agent` are the same carrier (see above), so a state transition is
operation application under its state-level name.  The first-order theorems and
the collapse demonstrations are stated over *states*, and the attached
mathematics carries both `apply` and `apply_state` (Σᴿ, *Definition — state
transition*); this keeps both readings of the same transition available without
introducing a second primitive.
-/
abbrev apply_state : Operation → State → State := apply

/- -----------------
   Operation Combinators
   ----------------- -/

/--
Sequential composition of operations.

`composeOp F G` is the operation that first applies `F` and then `G` — the
algebra's informal `G ∘ F`.  `Operation` is an abstract sort, so composition
is a primitive of the signature (Σᴿ, *Operation composition*), not the
function-space `∘`.
-/
axiom composeOp : Operation → Operation → Operation

/--
The identity operation.
-/
axiom IdOp : Operation

/--
`Iterate G n` is the operation that applies `G` exactly `n` times.
-/
axiom Iterate : Operation → Nat → Operation

/- -----------------
   Admissibility (Primitive)
   ----------------- -/

axiom Admissible : Operation → Prop

/- -----------------
   Core Invariants (Axiomatic)
   ----------------- -/

/--
Legitimacy (Primitive)

Legitimacy is the structural predicate on operations whose content is fixed by
the Tier‑2 axioms. It is *not* derived here: the justifications in
`SigmaR/Justifications` characterise it as invariant preservation.
-/
axiom Legitimate : Operation → Prop

/--
Domination Pressure (Primitive)

`DomPressure s` is the domination pressure of a configuration, the supremum of
dependency growth and exit fragility over its agents
(Σᴿ, *Definition — Domination Pressure*).
-/
axiom DomPressure : State → Nat

/--
Domination pressure does not escalate under admissible operations.

This is the structural form of the Tier‑1 guarantee that admissibility cannot
buy autonomy with domination.
-/
axiom DomPressure_monotonic :
  ∀ (F : Operation) (s : State),
    Admissible F →
    DomPressure (apply F s) ≤ DomPressure s

/--
ALRP — Autonomy-Limiting Reflex Principle (structural form)

Admissible operations do not reduce standing
for any agent.
-/
axiom ALRP :
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ a ≤ σ (apply F a)

/--
Capacity-Indexed Autonomy (CIA)

1. Standing is bounded by capacity via B
2. B is monotone in its capacity argument
-/
axiom CapacityBound :
  (∀ a : Agent, σ a ≤ B (cap a)) ∧
  (∀ c₁ c₂ : Nat, c₁ ≥ c₂ → B c₁ ≥ B c₂)

/- -----------------
   Successor Realizer
   ----------------- -/

/--
Existence of a successor-standing agent.

No assumptions about reachability, dynamics,
or admissible operations are made here.
-/
axiom SucRealizer : Agent → Agent

axiom SucRealizer_spec :
  ∀ a : Agent,
    σ (SucRealizer a) = Nat.succ (σ a)

/- -----------------
   Non-Triviality
   ----------------- -/

/--
The algebra is non-degenerate:
there exists at least one agent
with positive (non-zero) standing.
-/
axiom StandingNontrivial :
  ∃ a : Agent, σ a = 1

/- -----------------
   Derived Order Hygiene (Non-Axiomatic)
   ----------------- -/

/--
Standing order is reflexive.
-/
theorem standing_refl :
  ∀ a : Agent, σ a ≤ σ a :=
by
  intro a
  exact Nat.le_refl _

/--
Standing order is transitive.
-/
theorem standing_trans :
  ∀ a b c : Agent,
    σ a ≤ σ b →
    σ b ≤ σ c →
    σ a ≤ σ c :=
by
  intro a b c h₁ h₂
  exact Nat.le_trans h₁ h₂

/- -----------------
   Derived Core Lemmas
   ----------------- -/

/--
Standing preservation rephrased as a predicate.
This introduces no new assumptions.
-/
def StandingPreserved (F : Operation) : Prop :=
  ∀ a : Agent, σ a ≤ σ (apply F a)

/--
Admissible operations preserve standing.
This is a direct consequence of ALRP.
-/
theorem admissible_preserves_standing :
  ∀ F : Operation,
    Admissible F → StandingPreserved F :=
by
  intro F hAdm a
  exact ALRP F a hAdm

/--
Successor strictly increases standing.
-/
theorem successor_strict :
  ∀ a : Agent, σ a < σ (SucRealizer a) :=
by
  intro a
  rewrite [SucRealizer_spec]
  exact Nat.lt_succ_self _

end SigmaR
