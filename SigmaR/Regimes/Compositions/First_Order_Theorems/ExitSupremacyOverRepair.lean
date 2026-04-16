import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Exit Supremacy over Repair
   =========================================================

   Statement:
   Exit is structurally prior to repair.

   Informally:
   If an agent has access to a viable exit, then
   the existence or application of remedy must not
   condition, delay, or foreclose that exit.

   This theorem asserts a strict ordering:
   exit is never subordinated to repair.

   This is a first‑order semantic consequence of the
   Exit + Remedy and Autonomy + Remedy compositions.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Exit Supremacy over Repair
   ----------------- -/

axiom Exit_supremacy_over_repair :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (R : Operation),
      Remedy R →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F a)

end SigmaR
