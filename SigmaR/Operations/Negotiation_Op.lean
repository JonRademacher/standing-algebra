import SigmaR.StandingAlgebra_RegimeStacked
import SigmaR.Justifications.Regime_Legitimacy.ExitRegime.ExitPreservation_Justification
import SigmaR.Operations.ResolutionMethodDistinctness_Op

namespace SigmaR

/--
Operations-level invariant (Negotiation):

Negotiation preserves admissibility and exit
for all affected agents.
-/
axiom NegotiationInvariant :
  ∀ (F : Operation),
    NegotiationOp F →
    Admissible F ∧ ∀ s : State, ExitPreserved F s

/--
Derived theorem:

Negotiation operations are non-coercive adjustments.
-/
theorem NegotiationAdmissible
  (F : Operation)
  (hN : NegotiationOp F) :
  Admissible F ∧ ∀ s : State, ExitPreserved F s :=
by
  exact NegotiationInvariant F hN

end SigmaR
