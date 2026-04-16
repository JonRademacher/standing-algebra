import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Autonomy Repair Requirement
   =========================================================

   Statement:
   Reduction of autonomy or capacity generates an
   obligation to repair when repair is possible.

   Informally:
   If an agent’s autonomy is reduced, and some
   remedy operation exists, then some remedy must
   be applicable that does not worsen standing.

   This obligation is conditional:
   no repair is required when repair is impossible.

   This theorem is a first‑order semantic consequence
   of the Autonomy + Remedy composition.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Autonomy Repair Requirement
   ----------------- -/

axiom Autonomy_repair_requirement :
  ∀ (a : Agent),
    AutonomyReduced a →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation,
      Remedy R ∧
      σ (apply R a) ≥ σ a

end SigmaR
