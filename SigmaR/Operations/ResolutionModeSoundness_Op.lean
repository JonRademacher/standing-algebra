import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Semantic behavior predicates.

These capture what an operation *does*,
not how it is labeled.
-/
constant BehavesAsNegotiation      : Operation → Prop
constant BehavesAsCooperation      : Operation → Prop
constant BehavesAsCompromise       : Operation → Prop
constant BehavesAsTragicAcceptance : Operation → Prop

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
