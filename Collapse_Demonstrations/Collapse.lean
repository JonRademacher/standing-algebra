/-
  Collapse_Demonstrations.Collapse

  This file defines the logical notion of "collapse" used by the
  SMT/Z3 collapse demonstrations.

  Lean does NOT search for collapse models.
  Instead, this predicate is used later to prove that
  collapse is impossible under Standing Algebra.
-/

namespace Collapse_Demonstrations

/--
  Abstract types, mirroring the SMT-level structure.
-/
variable
  (Agent : Type)
  (Operation : Type)

/--
  Standing / score / value function.
-/
variable
  (σ : Agent → Int)

/--
  Application of an operation to an agent.
-/
variable
  (Apply : Operation → Agent → Agent)

/--
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

end Collapse_Demonstrations
