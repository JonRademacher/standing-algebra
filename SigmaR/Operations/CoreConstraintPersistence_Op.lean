import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/--
Operations-level predicate:

`F` satisfies all core non-domination constraints
(ALRP, CIA, NRPP, STC-5).

Declared here, at the operations layer, because it classifies operations;
the Tier‑2 justification imports it rather than redeclaring it.
-/
axiom CoreConstraintsSatisfied : Operation → Prop

/--
Operations-level invariant:

All operations preserve core constraints under composition.
This is a structural fact, not a legitimacy judgment.
-/
axiom CoreConstraintInvariant :
  ∀ (F G : Operation),
    CoreConstraintsSatisfied F →
    CoreConstraintsSatisfied G →
    CoreConstraintsSatisfied (composeOp F G)

/--
Derived theorem:

Core constraints are closed under operation sequencing.
-/
theorem CoreConstraintsClosedUnderComposition
  (F G : Operation)
  (hF : CoreConstraintsSatisfied F)
  (hG : CoreConstraintsSatisfied G) :
  CoreConstraintsSatisfied (composeOp F G) :=
by
  exact CoreConstraintInvariant F G hF hG

end SigmaR
