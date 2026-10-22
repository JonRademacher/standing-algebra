import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Operations.ResolutionMethodDistinctness_Op

namespace SigmaR

/--
Operations-level invariant (Tragic Acceptance):

If tragic acceptance applies, the identity
or non-intervention operation is selected.
-/
axiom TragicAcceptanceInvariant :
  ∀ (F : Operation),
    TragicAcceptanceOp F →
    F = IdentityOp

/--
Derived theorem:

Tragic acceptance forbids coercive resolution.
-/
theorem TragicAcceptanceIsNonIntervention
  (F : Operation)
  (hT : TragicAcceptanceOp F) :
  F = IdentityOp :=
by
  exact TragicAcceptanceInvariant F hT

end SigmaR
