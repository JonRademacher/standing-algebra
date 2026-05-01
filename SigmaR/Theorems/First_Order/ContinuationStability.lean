import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Continuation Stability
   =========================================================

   Proven version.

   This theorem states that successor continuation
   remains structurally stable under admissible
   bounded drift.

   It is a direct consequence of the
   Successor + Drift first‑order composition.
   ========================================================= -/

/- -----------------
   Continuation Stability
   ----------------- -/

theorem Continuation_stability :
  ∀ (a : Agent),
    (∃ F : Operation, SuccessorOp F) →
    ∀ (D : Operation),
      Drift D →
      ∃ F : Operation,
        SuccessorOp F ∧
        σ (apply F (apply D a)) =
          Nat.succ (σ (apply D a)) :=
by
  intro a hSucc D hDrift
  rcases hSucc with ⟨F_succ, hF_succ⟩
  refine ⟨F_succ, hF_succ, ?_⟩
  exact Successor_preserved_under_drift F_succ D a hF_succ hDrift

end SigmaR
