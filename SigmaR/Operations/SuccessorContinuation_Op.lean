import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level invariant:

Successor operations admit continuation paths
that preserve admissibility.
-/
axiom SuccessorContinuationInvariant :
  ∀ (F : Operation),
    SuccessorConsistent F →
    ∀ s : State,
      ∃ G : Operation,
        Admissible (composeOp F G)

/--
Derived theorem:

Successor operations are not operational dead-ends.
-/
theorem SuccessorHasOperationalContinuation
  (F : Operation)
  (hSucc : SuccessorConsistent F) :
  ∀ s : State,
    ∃ G : Operation,
      Admissible (composeOp F G) :=
by
  intro s
  exact SuccessorContinuationInvariant F hSucc s

end SigmaR
