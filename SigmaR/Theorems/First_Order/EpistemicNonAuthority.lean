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
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    ¬ Admissible F :=
by
  intro F a hClaim
  rcases hClaim with ⟨c, hUses⟩
  exact Claim_cannot_authorize_admissibility F c hUses

end SigmaR
