import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level invariant:

There always exists at least one continuation
path preserving admissibility.
-/
axiom ContinuationAdmissibilityStable :
  ∀ (F : Operation),
    Admissible F →
    ∀ n : Nat,
      ∃ G : Operation,
        Admissible (Iterate G n ∘ F)

/--
Derived theorem:

Admissibility is continuation-stable.
-/
theorem AdmissibilityStableUnderContinuation
  (F : Operation)
  (hF : Admissible F) :
  ∀ n : Nat,
    ∃ G : Operation,
      Admissible (Iterate G n ∘ F) :=
by
  intro n
  exact ContinuationAdmissibilityStable F hF n

end SigmaR
