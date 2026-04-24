import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Resolution methods are distinct structural modes.

IMPORTANT:
This file does NOT assert that an operation may only
instantiate one method.

It asserts only that:
  • No resolution method may be reduced to another
  • No method may operate *as* another
  • Semantic identity is preserved

Joint use is explicitly allowed.
-/

constant NegotiationOp       : Operation → Prop
constant CooperationOp       : Operation → Prop
constant CompromiseOp        : Operation → Prop
constant TragicAcceptanceOp  : Operation → Prop

/--
Resolution method non-reducibility.

No resolution method is equivalent to another.
-/
axiom ResolutionMethodsDistinct :
  (∀ F : Operation, NegotiationOp F → ¬ CompromiseOp F) ∧
  (∀ F : Operation, CompromiseOp F → ¬ NegotiationOp F) ∧
  (∀ F : Operation, CooperationOp F → ¬ CompromiseOp F) ∧
  (∀ F : Operation, CompromiseOp F → ¬ CooperationOp F) ∧
  (∀ F : Operation, TragicAcceptanceOp F →
      ¬ NegotiationOp F ∧
      ¬ CooperationOp F ∧
      ¬ CompromiseOp F)

/--
Derived theorems: semantic separation only.

These do NOT forbid joint participation.
They forbid semantic collapse.
-/
theorem NegotiationNotCompromise
  (F : Operation)
  (hN : NegotiationOp F) :
  ¬ CompromiseOp F :=
(ResolutionMethodsDistinct).left F hN

end SigmaR
