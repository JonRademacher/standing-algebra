import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: No Slow Continuation Denial
   =========================================================

   Statement:
   There is no admissible, bounded way to gradually deny
   successor access via drift.

   Informally:
   If successor access exists for an agent, then
   after any admissible drift step, successor access
   still exists.

   This theorem is a first‑order semantic consequence
   of the Successor + Drift compositions.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   No Slow Continuation Denial
   ----------------- -/

axiom No_slow_continuation_denial :
  ∀ (a : Agent),
    (∃ F : Operation, SuccessorOp F) →
    ∀ (D : Operation),
      Drift D →
      ∃ F : Operation,
        SuccessorOp F ∧
        σ (apply F (apply D a)) = Nat.succ (σ (apply D a))

end SigmaR
