import Std

open Nat

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

/- -----------------
   Admissibility (Primitive)
   ----------------- -/

axiom Admissible : Operation → Prop

/- -----------------
   Core Invariants (Axiomatic)
   ----------------- -/

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
