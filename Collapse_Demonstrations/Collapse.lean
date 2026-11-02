/-
  Collapse.lean

  Logical definition of "collapse" shared across
  Lean, Coq, and SMT-level interpretations.

  This file defines collapse as a predicate.
  Proofs relating collapse to Standing Algebra
  are introduced in later files.
-/

namespace StandingAlgebra

/-
  Abstract types, mirroring the SMT-level structure.
-/
variable
  (Agent : Type)
  (Operation : Type)

/-
  Standing / score / value function.
-/
variable
  (σ : Agent → Int)

/-
  Application of an operation to an agent.
-/
variable
  (Apply : Operation → Agent → Agent)

/-
  Predicate stating an operation is admissible.
-/
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
