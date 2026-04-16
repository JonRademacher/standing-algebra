import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Successor Non‑Erosion
   =========================================================

   Statement:
   Bounded drift cannot eliminate access to successor standing.

   Informally:
   If successor access exists, then no admissible drift
   operation can erode that access.

   This theorem is a direct instantiation of the
   Successor + Drift first‑order composition.

   No new axioms are introduced here.
   ========================================================= -/

/- -----------------
   Successor Non‑Erosion Theorem
   ----------------- -/

theorem Successor_non_erosion :
  ∀ (a : Agent),
    (∃ F : Operation, SuccessorOp F) →
    (∀ D : Operation, Drift D →
       ∃ F : Operation,
         SuccessorOp F ∧
         σ (apply F (apply D a)) = Nat.succ (σ (apply D a))) :=
by
  -- This theorem follows directly from the
  -- SuccessorDrift first‑order composition.
  --
  -- Proof will be supplied once the composition
  -- axioms are imported as lemmas.
  admit

end SigmaR
