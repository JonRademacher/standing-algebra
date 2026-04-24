import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Predicate: no resolution method is admissible.
-/
constant NoResolutionAvailable : Operation → Prop

/--
Resolution fallback rule:

If no resolution method applies,
only non-intervention is permitted.
-/
axiom ResolutionFallback :
  ∀ F : Operation,
    NoResolutionAvailable F →
    F = IdentityOp

/--
Derived theorem:

No forced resolution under plural irreconcilability.
-/
theorem TragicAcceptanceFallback
  (F : Operation)
  (hNone : NoResolutionAvailable F) :
  F = IdentityOp :=
ResolutionFallback F hNone

end SigmaR
