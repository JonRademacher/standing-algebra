import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Risk Regime
   =========================================================

   This regime formalizes informational risk without
   authorizing domination.

   Risk:
   - may be represented and propagated,
   - may inform diagnostics,
   - may not authorize harm,
   - may not override standing or admissibility,
   - must respect symmetry.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Risk Structure
   ----------------- -/

-- Risk load carried by an agent
axiom RiskLoad : Agent → Nat

-- Operations that impose or carry risk for an agent
axiom RiskBearer : Operation → Agent → Prop

/- -----------------
   Risk Propagation
   ----------------- -/

-- Risk load is monotonic under risk-bearing operations
axiom Risk_monotonic :
  ∀ (F : Operation) (a : Agent),
    RiskBearer F a →
    RiskLoad (apply F a) ≥ RiskLoad a

/- -----------------
   Risk Non-Authority
   ----------------- -/

-- Risk does not authorize admissibility
axiom Risk_not_authoritative :
  ∀ (F : Operation) (a : Agent),
    RiskBearer F a →
    ¬ Admissible F

-- Risk does not override standing preservation
axiom Risk_no_standing_override :
  ∀ (F : Operation) (a : Agent),
    RiskBearer F a →
    σ (apply F a) ≥ σ a

/- -----------------
   Risk Symmetry
   ----------------- -/

-- Risk-sensitive symmetry for equal standing and capacity
axiom Risk_symmetry :
  ∀ (F : Operation) (a₁ a₂ : Agent),
    RiskBearer F a₁ →
    RiskBearer F a₂ →
    σ a₁ = σ a₂ →
    σ (apply F a₁) = σ (apply F a₂)

end SigmaR
