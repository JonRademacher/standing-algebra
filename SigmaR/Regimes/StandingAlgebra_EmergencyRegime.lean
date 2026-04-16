import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Emergency Regime
   =========================================================

   This regime formalizes exceptional, bounded departures
   from normal operation.

   Emergency:
   - is admissible but constrained,
   - cannot improve standing,
   - cannot persist indefinitely,
   - creates an obligation to repair,
   - must not normalize into standard operation.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Emergency Structure
   ----------------- -/

-- Emergency operations
axiom Emergency : Operation → Prop

-- Predicate indicating an emergent wrong state
axiom EmergentWrong : State → Prop

-- Repair operations (introduced here only as a symbol;
-- full semantics are in RemedyRegime)
axiom Repair : Operation → Prop

/- -----------------
   Emergency Admissibility
   ----------------- -/

-- Emergency operations are admissible
axiom Emergency_admissible :
  ∀ F : Operation, Emergency F → Admissible F

/- -----------------
   Emergency Boundedness
   ----------------- -/

-- Emergency cannot increase standing
axiom Emergency_no_standing_gain :
  ∀ (F : Operation) (a : Agent),
    Emergency F →
    σ (apply F a) ≤ σ a

-- Emergency effects must be bounded to one successor step
axiom Emergency_bounded :
  ∀ (F : Operation) (a : Agent),
    Emergency F →
    σ a ≤ Nat.succ (σ (apply F a))

/- -----------------
   No Normalization of Emergency
   ----------------- -/

-- Emergency operations are not legitimate
axiom Emergency_not_legitimate :
  ∀ F : Operation, Emergency F → ¬ Legitimate F

/- -----------------
   Emergency Termination
   ----------------- -/

-- Emergency implies the existence of a repair obligation
axiom Emergency_requires_repair :
  ∀ s : State,
    EmergentWrong s →
    ∃ R : Operation, Repair R

-- Emergency must not persist without resolution
axiom Emergency_not_idempotent :
  ∀ (F : Operation),
    Emergency F →
    ¬ (∀ a : Agent, apply F (apply F a) = apply F a)

end SigmaR
