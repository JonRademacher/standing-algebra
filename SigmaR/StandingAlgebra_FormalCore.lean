import Std

open Nat

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Formal Core (Lean 4)
   =========================================================

   This file contains ONLY the irreducible core axioms
   of Standing Algebra. No regimes (drift, exit, remedy,
   risk, emergency) appear here.

   Every regime must import this file.
   ========================================================= -/

/- -----------------
   Primitive Sorts
   ----------------- -/

axiom Agent : Type
axiom Operation : Type

/- -----------------
   Standing Structure
   ----------------- -/

axiom σ : Agent → Nat        -- standing
axiom cap : Agent → Nat      -- capacity index
axiom B : Nat → Nat          -- capacity bound

/- -----------------
   Operations
   ----------------- -/

axiom apply : Operation → Agent → Agent

/- -----------------
   Admissibility
   ----------------- -/

axiom Admissible : Operation → Prop

/- -----------------
   Core Invariants
   ----------------- -/

-- ALRP: admissible operations do not reduce standing
axiom ALRP :
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ a ≤ σ (apply F a)

-- Capacity-indexed autonomy
axiom CapacityBound :
  (∀ a : Agent, σ a ≤ B (cap a)) ∧
  (∀ c₁ c₂ : Nat, c₁ ≥ c₂ → B c₁ ≥ B c₂)

-- Successor realizer (existence only; no dynamics assumed)
axiom SucRealizer : Agent → Agent
axiom SucRealizer_spec :
  ∀ a : Agent, σ (SucRealizer a) = Nat.succ (σ a)

/- -----------------
   Non-triviality
   ----------------- -/

-- There exists at least one agent with nonzero standing
axiom StandingNontrivial :
  ∃ a : Agent, σ a = 1

/- -----------------
   Derived Core Lemmas
   ----------------- -/

def StandingPreserved (F : Operation) : Prop :=
  ∀ a : Agent, σ a ≤ σ (apply F a)

theorem admissible_preserves_standing :
  ∀ F : Operation,
    Admissible F → StandingPreserved F :=
by
  intro F hAdm a
  exact ALRP F a hAdm

theorem successor_strict :
  ∀ a : Agent, σ a < σ (SucRealizer a) :=
by
  intro a
  rewrite [SucRealizer_spec]
  exact Nat.lt_succ_self _

end SigmaR
