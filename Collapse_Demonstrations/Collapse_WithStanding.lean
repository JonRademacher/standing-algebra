/-
  Collapse_Demonstrations.Collapse_WithStanding

  Lean analogue of:

    Collapse_With_StandingAlgebra.smt2  →  UNSAT

  This file proves that under Standing Algebra assumptions,
  collapse is impossible.
-/

namespace Collapse_Demonstrations

import Collapse_Demonstrations.Collapse

/--
  Standing Algebra monotonicity axiom (ALRP):

  Admissible operations never decrease standing.
-/
variable
  (Agent : Type)
  (Operation : Type)
  (σ : Agent → Int)
  (Apply : Operation → Agent → Agent)
  (Admissible : Operation → Prop)

/--
  Standing Algebra axiom:
  admissible operations preserve or increase standing.
-/
def StandingAlgebra : Prop :=
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ (Apply F a) ≥ σ a

/--
  Under Standing Algebra, collapse is impossible.
-/
theorem noCollapse_under_StandingAlgebra
  (SA : StandingAlgebra Agent Operation σ Apply Admissible) :
  ¬ Collapse Agent Operation σ Apply Admissible :=
by
  intro hCollapse
  rcases hCollapse with ⟨F, a, hAdm, hDecrease⟩

  -- From Standing Algebra we get non-decrease
  have hNonDecrease : σ (Apply F a) ≥ σ a :=
    SA F a hAdm

  -- Contradiction: σ(Apply F a) < σ a and ≥ σ a
  exact lt_irrefl _ (lt_of_lt_of_le hDecrease hNonDecrease)

end Collapse_Demonstrations
