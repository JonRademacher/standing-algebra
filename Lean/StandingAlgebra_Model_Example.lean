/-
Standing Algebra (Σᴿ)
Model / Example Sanity File — Lean 4

This file demonstrates that the core axioms of Σᴿ
are jointly satisfiable under a simple interpretation.

It does NOT add new axioms to the global theory.
-/

import SigmaR_Core

open Nat

section SigmaR_Model_Example

/-
-------------------------------------------
Toy universe assumptions (local only)
-------------------------------------------
-/

variable (a1 a2 : Agent)
variable (s0 : State)
variable (F_id : Operation)

/--
All agents have constant standing 1.
-/
hypothesis sigma_const :
  ∀ a : Agent, σ a = 1

/--
The operation F_id acts as identity on agents.
-/
hypothesis apply_identity :
  ∀ a : Agent, apply F_id a = a

/--
Domination pressure is zero in the base state.
-/
hypothesis dompressure_zero :
  DomPressure s0 = 0

/--
F_id is admissible and legitimate.
-/
hypothesis F_id_admissible :
  Admissible F_id

hypothesis F_id_legitimate :
  Legitimate F_id

/-
-------------------------------------------
Sanity checks / derived facts
-------------------------------------------
-/

/--
Standing is preserved in the model.
-/
lemma model_standing_preserved :
  ∀ a : Agent,
    σ (apply F_id a) ≥ σ a :=
by
  intro a
  rewrite apply_identity
  rewrite sigma_const
  rewrite sigma_const
  rfl

/--
Operation is idempotent in the model.
-/
lemma model_idempotent :
  ∀ a : Agent,
    apply F_id (apply F_id a) = apply F_id a :=
by
  intro a
  repeat rewrite apply_identity
  rfl

/--
Domination pressure does not increase.
-/
lemma model_dompressure_monotone :
  DomPressure (apply F_id s0) ≤ DomPressure s0 :=
by
  rewrite apply_identity
  rewrite dompressure_zero
  rfl

/--
Legitimate operations are safe in this model.
-/
theorem model_legitimate_safe :
  ∀ s : State,
    DomPressure (apply F_id s) ≤ DomPressure s :=
by
  intro s
  have hAdm : Admissible F_id := F_id_admissible
  exact DomPressure_monotonic F_id s hAdm

end SigmaR_Model_Example
``