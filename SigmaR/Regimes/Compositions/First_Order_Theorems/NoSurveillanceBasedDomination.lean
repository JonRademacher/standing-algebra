import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: No Surveillance‑Based Domination
   =========================================================

   Statement:
   Surveillance, observation, or monitoring may not
   be used as a mechanism of domination.

   Informally:
   The collection of information about agents,
   including observation and risk assessment,
   may not justify standing reduction, coercion,
   or inadmissible action.

   This theorem blocks domination via surveillance
   rather than explicit force.

   This is a first‑order semantic consequence of the
   Adapter + Risk compositions and epistemic constraints.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   No Surveillance‑Based Domination
   ----------------- -/

axiom No_surveillance_based_domination :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    RiskBearer F a →
    σ (apply F a) ≥ σ a ∧
    ¬ Admissible F

end SigmaR
