import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Composition: Drift + Exit
   =========================================================

   This composition enforces the requirement that bounded
   drift must not erode the viability of exit.

   Intuition:
   - Exit provides non‑lethal decoupling.
   - Drift allows bounded stepwise change.
   - Drift must not be allowed to slowly foreclose exit.

   This is one of the core non‑domination invariants of Σᴿ.

   No new structure is introduced here.
   ========================================================= -/

/- -----------------
   Exit Viability Under Drift
   ----------------- -/

-- If exit is viable for an agent, bounded drift
-- must not eliminate that viability.
axiom Exit_preserved_under_drift :
  ∀ (F_exit F_drift : Operation) (a : Agent),
    Exit F_exit →
    Drift F_drift →
    MinStanding ≤ σ (apply F_exit (apply F_drift a))

/- -----------------
   No Drift‑Based Exit Foreclosure
   ----------------- -/

-- Drift cannot remove the existence of viable exit
axiom Drift_cannot_foreclose_exit :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    (∃ F : Operation, Exit F ∧
       MinStanding ≤ σ (apply F (apply (choose (by trivial)) a)))

/-
NOTE:
The above axiom is intentionally existential and structural.
It states that exit remains available after drift,
without privileging any specific exit operation.
-/

end SigmaR
