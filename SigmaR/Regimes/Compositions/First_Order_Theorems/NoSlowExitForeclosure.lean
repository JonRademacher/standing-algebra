import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: No Slow Exit Foreclosure
   =========================================================

   Statement:
   There is no admissible, bounded way to gradually
   eliminate all viable exit options.

   Informally:
   If an agent has access to a viable exit, then
   after any admissible drift step, some viable
   exit must still exist.

   This theorem is a first‑order semantic consequence
   of the Drift + Exit composition.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   No Slow Exit Foreclosure
   ----------------- -/

axiom No_slow_exit_foreclosure :
  ∀ (a : Agent),
    (∃ F : Operation, Exit F ∧ MinStanding ≤ σ (apply F a)) →
    ∀ (D : Operation),
      Drift D →
      ∃ F : Operation,
        Exit F ∧
        MinStanding ≤ σ (apply F (apply D a))

end SigmaR
