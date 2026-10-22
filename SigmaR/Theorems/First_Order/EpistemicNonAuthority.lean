import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Epistemic Non‑Authority
   =========================================================

   Proven version.

   This theorem states that epistemic inputs
   (claims, evidence, models, proxies) may inform
   action but may never confer admissibility or
   coercive authority.

   It is a direct consequence of the Adapter
   regime's non‑authoritativeness constraint.
   ========================================================= -/

/- -----------------
   Epistemic Non‑Authority
   ----------------- -/

theorem Epistemic_non_authority :
  ∀ (F : Operation) (c : Claim),
    usesClaim F c →
    ¬ Authority c :=
by
  intro F c hUses
  exact Claim_not_Admissible F c hUses

end SigmaR
