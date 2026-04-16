import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Successor Non‑Erosion
   =========================================================

   Proven version.

   This theorem is a direct consequence of the
   first‑order Successor + Drift composition.

   It is safe to prove at this stage because it
   introduces no new commitments and merely
   repackages an existing structural axiom.
   ========================================================= -/

/- -----------------
   Successor Non‑Erosion
   ----------------- -/

theorem Successor_non_erosion :
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
