/-
  Collapse.lean

  Logical definition of "collapse" shared across
  Lean, Coq, and SMT-level interpretations.

  This file defines collapse as a predicate.
  Proofs relating collapse to Standing Algebra
  are introduced in later files.
-/

namespace StandingAlgebra

-- Abstract types
variable
  (Agent : Type)
  (Operation : Type)

-- Standing / value function
variable
  (σ : Agent → Int)

-- Application of an operation
variable
  (Apply : Operation → Agent → Agent)

-- Admissibility predicate
variable
  (Admissible : Operation → Prop)

/--
  Collapse occurs if there exists an admissible operation
  that strictly reduces standing for some agent.

  SMT analogue:
    ∃ F a, Admissible F ∧ σ (Apply F a) < σ a
-/
def Collapse : Prop :=
  ∃ (F : Operation) (a : Agent),
    Admissible F ∧
    σ (Apply F a) < σ a

end StandingAlgebra
