import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Composition: Successor + Drift
   =========================================================

   This composition encodes the requirement that bounded
   drift must not obstruct access to successor standing.

   Intuition:
   - Successor guarantees +1 continuation.
   - Drift allows bounded stepwise change.
   - Together, successor viability must be preserved.

   This file introduces a CONDITIONAL OBLIGATION:
   successor access must remain effective under drift.

   No new structure is introduced here.
   ========================================================= -/

/- -----------------
   Successor Viability Under Drift
   ----------------- -/

-- If an agent has access to a successor operation,
-- and drift operations are applied,
-- successor standing remains reachable.
axiom Successor_preserved_under_drift :
  ∀ (F_succ F_drift : Operation) (a : Agent),
    SuccessorOp F_succ →
    Drift F_drift →
    σ (apply F_succ (apply F_drift a)) = Nat.succ (σ (apply F_drift a))

/- -----------------
   No Drift‑Based Successor Obstruction
   ----------------- -/

-- Drift may not eliminate successor availability
axiom Drift_cannot_block_successor :
  ∀ (a : Agent),
    (∃ F : Operation, SuccessorOp F) →
    (∃ F : Operation, SuccessorOp F ∧
       σ (apply F a) = Nat.succ (σ a))

end SigmaR
