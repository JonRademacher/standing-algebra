import SigmaR_Basics

open SigmaR

namespace SigmaR

theorem model_legitimate_safe_example
  (s0 : State)
  (F_id : Operation)
  (sigma_const : ∀ a : Agent, σ a = 1)
  (apply_identity : ∀ a : Agent, apply F_id a = a)
  (dompressure_zero : DomPressure s0 = 0)
  (F_id_admissible : Admissible F_id)
  (F_id_legitimate : Legitimate F_id) :
  ∀ s : State,
    DomPressure (apply F_id s) ≤ DomPressure s :=
by
  intro s
  exact DomPressure_monotonic F_id s F_id_admissible

end SigmaR

