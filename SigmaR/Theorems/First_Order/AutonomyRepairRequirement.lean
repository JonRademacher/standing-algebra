import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Autonomy Repair Requirement
   =========================================================

   Proven version.

   This theorem states that reduction of autonomy
   generates an obligation to repair when repair
   is possible.

   It is a direct consequence of the
   Autonomy + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Autonomy Repair Requirement
   ----------------- -/

theorem Autonomy_repair_requirement :
  ∀ (a : Agent),
    AutonomyReduced a →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation,
      Remedy R ∧
      σ (apply R a) ≥ σ a :=
by
  intro a hAut hRemedyExists
  exact Remedy_required_when_autonomy_reduced a hAut hRemedyExists

end SigmaR
