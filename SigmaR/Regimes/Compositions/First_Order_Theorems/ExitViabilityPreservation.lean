import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Exit Viability Preservation
   =========================================================

   Statement:
   Viable exit cannot be eroded by bounded admissible drift.

   Informally:
   If an agent has access to a viable exit, then
   after any admissible drift step, some viable
   exit remains available.

   This theorem is a direct first‑order semantic
   consequence of the Drift + Exit composition.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Exit Viability Preservation
   ----------------- -/

axiom Exit_viability_preserved :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (D : Operation),
      Drift D →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F (apply D a))

end SigmaR
