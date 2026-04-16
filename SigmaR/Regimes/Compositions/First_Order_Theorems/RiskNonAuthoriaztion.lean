import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Risk Non‑Authorization
   =========================================================

   Proven version.

   This theorem states that informational risk
   may not authorize admissibility or coercive
   action.

   It is a direct consequence of the Risk regime
   and the Adapter + Risk first‑order constraint.
   ========================================================= -/

/- -----------------
   Risk Non‑Authorization
   ----------------- -/

theorem Risk_non_authorization :
  ∀ (F : Operation) (a : Agent),
    RiskBearer F a →
    ¬ Admissible F :=
by
  intro F a hRisk
  exact Risk_cannot_authorize_admissibility F a hRisk

end SigmaR
