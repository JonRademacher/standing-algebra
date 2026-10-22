import Collapse_Demonstrations.Collapse
import Mathlib.Data.Int.Basic

/-
  Collapse_Demonstrations.Collapse_WithStanding

  Lean analogue of:

    Collapse_With_StandingAlgebra.smt2  →  UNSAT

  This file proves that under Standing Algebra assumptions,
  collapse is impossible.
-/

namespace Collapse_Demonstrations

/--
  Standing Algebra axiom:
  admissible operations preserve or increase standing.
-/
def StandingAlgebra
  (Agent : Type)
  (Operation : Type)
  (σ : Agent → Int)
  (Apply : Operation → Agent → Agent)
  (Admissible : Operation → Prop) : Prop :=
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ (Apply F a) ≥ σ a

/--
  Under Standing Algebra, collapse is impossible.
-/
theorem noCollapse_under_StandingAlgebra
  (Agent : Type)
  (Operation : Type)
  (σ : Agent → Int)
  (Apply : Operation → Agent → Agent)
  (Admissible : Operation → Prop)
  (SA : StandingAlgebra Agent Operation σ Apply Admissible) :
  ¬ StandingAlgebra.Collapse Agent Operation σ Apply Admissible :=
by
  intro hCollapse
  rcases hCollapse with ⟨F, a, hAdm, hDecrease⟩

  -- From Standing Algebra we get non-decrease
  have hNonDecrease : σ (Apply F a) ≥ σ a :=
    SA F a hAdm

  -- Contradiction: σ(Apply F a) < σ a and ≥ σ a
  exact (Int.not_lt.mpr hNonDecrease) hDecrease

end Collapse_Demonstrations
