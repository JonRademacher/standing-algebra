import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: No Surveillance‑Based Domination
   =========================================================

   Proven version.

   This theorem states that surveillance, observation,
   or monitoring may not be used as a mechanism of
   domination: it neither reduces standing nor
   authorizes inadmissible action.

   It is a direct consequence of the
   Adapter + Risk first‑order composition.
   ========================================================= -/

/- -----------------
   No Surveillance‑Based Domination
   ----------------- -/

theorem No_surveillance_based_domination :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    RiskBearer F a →
    σ (apply F a) ≥ σ a ∧
    ¬ Admissible F :=
by
  intro F a hClaim hRisk
  constructor
  · -- Standing is not reduced by surveillance + risk
    exact AdapterRisk_no_standing_override F a hClaim hRisk
  · -- Surveillance + risk cannot authorize admissibility
    exact AdapterRisk_cannot_authorize_admissibility F a hClaim hRisk

end SigmaR
