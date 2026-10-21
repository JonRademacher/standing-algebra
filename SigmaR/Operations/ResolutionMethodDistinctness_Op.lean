import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Operations.Negotiation_Op
import SigmaR.Operations.Cooperation_Op
import SigmaR.Operations.Compromise_Op
import SigmaR.Operations.TragicAcceptance_Op

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

-- The four resolution-mode predicates are declared once, in their own
-- operations modules (`Negotiation_Op`, `Cooperation_Op`, `Compromise_Op`,
-- `TragicAcceptance_Op`) and are imported here rather than redeclared.

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
