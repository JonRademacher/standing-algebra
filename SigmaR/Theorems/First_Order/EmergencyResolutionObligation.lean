import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Emergency Resolution Obligation
   =========================================================

   Proven version.

   This theorem states that emergency conditions
   generate an obligation to resolve via remedy
   when remedy is possible.

   It is a direct consequence of the
   Emergency + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Emergency Resolution Obligation
   ----------------- -/

theorem Emergency_resolution_obligation :
  ∀ (s : State),
    EmergentWrong s →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation,
      Remedy R ∧
      ¬ EmergentWrong (apply_state R s) :=
by
  intro s hEmergency hRemedyExists
  exact Emergency_requires_remedy_when_possible s hEmergency hRemedyExists

end SigmaR
