import Std

open Nat

namespace SigmaR

set_option linter.unusedVariables false

axiom State : Type
abbrev Agent := State
axiom Operation : Type

axiom σ : Agent → Nat
axiom apply : Operation → State → State

axiom DomPressure : State → Nat

axiom Admissible : Operation → Prop
axiom Legitimate : Operation → Prop

axiom ALRP_standing_preservation :
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ a ≤ σ (apply F a)

axiom DomPressure_monotonic :
  ∀ (F : Operation) (s : State),
    Admissible F →
    DomPressure (apply F s) ≤ DomPressure s

axiom Realize_S : Agent → Agent
axiom realize_S_spec :
  ∀ a : Agent, σ (Realize_S a) = Nat.succ (σ a)

end SigmaR
