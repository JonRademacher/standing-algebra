import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Composition: Autonomy + Remedy
   =========================================================

   This composition encodes the requirement that
   when autonomy or capacity is reduced and
   remedy is possible, remedy is required.

   Crucially:
   - Remedy is NOT required when impossible.
   - No specific remedy is privileged.
   - No coercive enforcement is introduced.

   This is a CONDITIONAL OBLIGATION, not a regime.
   ========================================================= -/

/- -----------------
   Autonomy Reduction
   ----------------- -/

-- Autonomy reduction is detected structurally
-- (definition intentionally abstract)
axiom AutonomyReduced : Agent → Prop

/- -----------------
   Remedy Obligation Under Autonomy Reduction
   ----------------- -/

-- If autonomy is reduced and a remedy is possible,
-- then some remedy must be applied.
axiom Remedy_required_when_autonomy_reduced :
  ∀ (a : Agent),
    AutonomyReduced a →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation, Remedy R ∧ σ (apply R a) ≥ σ a

/- -----------------
   No Obligation When Remedy Impossible
   ----------------- -/

-- If no remedy exists, autonomy reduction does not
-- generate an impossible obligation.
axiom No_obligation_when_remedy_impossible :
  ∀ (a : Agent),
    AutonomyReduced a →
    ¬ (∃ R : Operation, Remedy R) →
    True

end SigmaR
