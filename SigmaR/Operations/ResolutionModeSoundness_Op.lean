import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Operations.Negotiation_Op
import SigmaR.Operations.Cooperation_Op
import SigmaR.Operations.Compromise_Op
import SigmaR.Operations.TragicAcceptance_Op

namespace SigmaR

/--
Semantic behavior predicates.

These capture what an operation *does*,
not how it is labeled.
-/
axiom BehavesAsNegotiation      : Operation → Prop
axiom BehavesAsCooperation      : Operation → Prop
axiom BehavesAsCompromise       : Operation → Prop
axiom BehavesAsTragicAcceptance : Operation → Prop

/--
Resolution soundness:

Behavior implies structural obligations.
-/
axiom ResolutionSoundness :
  (∀ F, BehavesAsNegotiation F → NegotiationOp F) ∧
  (∀ F, BehavesAsCooperation F → CooperationOp F) ∧
  (∀ F, BehavesAsCompromise F → CompromiseOp F) ∧
  (∀ F, BehavesAsTragicAcceptance F → TragicAcceptanceOp F)

/--
Derived theorem: no simulation loopholes.
-/
theorem NoNegotiationSimulation
  (F : Operation)
  (hB : BehavesAsNegotiation F) :
  NegotiationOp F :=
(ResolutionSoundness).left F hB

end SigmaR
