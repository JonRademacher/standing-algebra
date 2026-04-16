import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Composition: Adapter + Risk
   =========================================================

   This composition enforces the requirement that
   epistemic inputs (claims) and informational risk
   may not authorize admissibility or domination.

   Intuition:
   - Adapters produce claims, not authority.
   - Risk signals danger, not permission.
   - Together, they still must not justify coercion
     or admissible harm.

   This file introduces a CONDITIONAL CONSTRAINT.
   No new structure is introduced.
   ========================================================= -/

/- -----------------
   Claims and Risk Do Not Authorize Admissibility
   ----------------- -/

-- No operation becomes admissible due to claims and risk
axiom AdapterRisk_cannot_authorize_admissibility :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    RiskBearer F a →
    ¬ Admissible F

/- -----------------
   No Epistemic Domination
   ----------------- -/

-- Claims and risk may not justify standing reduction
axiom AdapterRisk_no_standing_override :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    RiskBearer F a →
    σ (apply F a) ≥ σ a

end SigmaR
