import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Composition: Exit + Remedy
   =========================================================

   This composition enforces the requirement that
   structural repair (remedy) must not foreclose
   viable exit.

   Intuition:
   - Exit guarantees non‑lethal decoupling.
   - Remedy repairs harm.
   - Repair must never trap agents or eliminate exit.

   This file introduces a CONDITIONAL CONSTRAINT,
   not a new regime.

   No new structure is introduced here.
   ========================================================= -/

/- -----------------
   Exit Preservation Under Remedy
   ----------------- -/

-- Applying a remedy must preserve exit viability.
axiom Exit_preserved_under_remedy :
  ∀ (F_exit F_remedy : Operation) (a : Agent),
    Exit F_exit →
    Remedy F_remedy →
    MinStanding ≤ σ (apply F_exit (apply F_remedy a))

/- -----------------
   No Remedy‑Based Exit Foreclosure
   ----------------- -/

-- Remedy must not remove the existence of viable exit.
axiom Remedy_cannot_foreclose_exit :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    (∃ F : Operation, Exit F ∧
       MinStanding ≤ σ (apply F (apply (choose (by trivial)) a)))

/-
NOTE:
This axiom is intentionally existential and non‑specific.
It states that exit remains available after remedy,
without privileging any particular exit or remedy operation.

The abstraction mirrors the Z3 composition discipline.
-/

end SigmaR
