import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Autonomy Protection
   =========================================================

   Proven version.

   This theorem states that autonomy reduction
   is a structurally significant event that must
   trigger the repair logic when repair is possible.

   It is a direct consequence of the
   Autonomy + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Autonomy Protection
   ----------------- -/

theorem Autonomy_protection :
  ∀ (a : Agent) (F : Operation),
    Admissible F →
    AutonomyReduced a →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation,
      Remedy R ∧
      σ (apply R a) ≥ σ a :=
by
  intro a F hAdm hAut hRemedyExists
  -- The admissibility of F is not needed beyond
  -- establishing that the autonomy reduction is
  -- structurally meaningful.
  exact Remedy_required_when_autonomy_reduced a hAut hRemedyExists

end SigmaR
