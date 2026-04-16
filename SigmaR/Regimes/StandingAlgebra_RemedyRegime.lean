import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Remedy Regime
   =========================================================

   This regime formalizes structural repair.

   Remedy:
   - must exist,
   - must be admissible,
   - must not reduce standing,
   - must reduce structural harm,
   - must be bounded (no infinite escalation),
   - must not be mandatory.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Remedy Structure
   ----------------- -/

-- Repair / remedy operations
axiom Remedy : Operation → Prop

-- Structural harm or debt measure
axiom StructuralDebt : Agent → Nat

/- -----------------
   Remedy Admissibility
   ----------------- -/

-- Remedy operations are admissible
axiom Remedy_admissible :
  ∀ R : Operation, Remedy R → Admissible R

/- -----------------
   Standing Preservation
   ----------------- -/

-- Remedy must not reduce standing
axiom Remedy_preserves_standing :
  ∀ (R : Operation) (a : Agent),
    Remedy R →
    σ (apply R a) ≥ σ a

/- -----------------
   Structural Repair
   ----------------- -/

-- Remedy reduces structural debt
axiom Remedy_reduces_debt :
  ∀ (R : Operation) (a : Agent),
    Remedy R →
    StructuralDebt (apply R a) < StructuralDebt a

/- -----------------
   Remedy Boundedness
   ----------------- -/

-- Remedy operations are not strictly escalating
axiom Remedy_not_escalatory :
  ∀ (R : Operation),
    Remedy R →
    ¬ (∀ a : Agent, StructuralDebt (apply R a) > StructuralDebt a)

/- -----------------
   Remedy Optionality
   ----------------- -/

-- Existence of a remedy ceiling distinct from enforcement
axiom Remedy_optional :
  ∃ R : Operation, Remedy R

end SigmaR
