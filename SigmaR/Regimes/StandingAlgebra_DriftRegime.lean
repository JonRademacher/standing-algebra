import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Drift Regime
   =========================================================

   This regime formalizes bounded change ("drift") in system
   evolution. Drift allows small local variation but prevents
   slow accumulation of domination via unbounded change.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Drift Structure
   ----------------- -/

-- Operations that are considered drift operations
axiom Drift : Operation → Prop

-- One-step bounded difference predicate
def OneStepDiff (x y : Nat) : Prop :=
  x = y ∨ x = Nat.succ y ∨ y = Nat.succ x

/- -----------------
   Bounded Drift Axioms
   ----------------- -/

-- Drift operations may only change standing by one step
axiom Drift_bounded_standing :
  ∀ (F : Operation) (a : Agent),
    Drift F →
    OneStepDiff (σ (apply F a)) (σ a)

-- Drift operations must be admissible
axiom Drift_admissible :
  ∀ (F : Operation),
    Drift F → Admissible F

/- -----------------
   No Drift Escalation
   ----------------- -/

-- Drift cannot strictly increase standing by more than one
axiom Drift_no_jump :
  ∀ (F : Operation) (a : Agent),
    Drift F →
    σ (apply F a) ≤ Nat.succ (σ a)

-- Drift cannot strictly decrease standing by more than one
axiom Drift_no_drop :
  ∀ (F : Operation) (a : Agent),
    Drift F →
    σ a ≤ Nat.succ (σ (apply F a))

/- -----------------
   Drift Neutrality
   ----------------- -/

-- Drift does not authorize non-admissible behavior
axiom Drift_no_authority :
  ∀ (F : Operation),
    Drift F → Admissible F

end SigmaR
