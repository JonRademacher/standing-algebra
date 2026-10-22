import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Structural Goodhart Exclusion
   =========================================================

   Proven version.

   This theorem states that proxy optimization or
   epistemic signal improvement may not undermine
   true standing.

   It excludes Goodhart-style failure at the
   structural level, not the statistical one.

   This is a direct consequence of the epistemic
   non-authority constraints in Σᴿ.
   ========================================================= -/

/- -----------------
   Structural Goodhart Exclusion
   ----------------- -/

theorem Structural_Goodhart_exclusion :
  ∀ (A : Adapter) (F : Operation) (a : Agent),
    usesClaim F (interpret A (observe A a)) →
    σ (apply F a) ≥ σ a :=
by
  intro A F a hClaim
  exact Adapter_no_standing_decrease A F a hClaim

end SigmaR
