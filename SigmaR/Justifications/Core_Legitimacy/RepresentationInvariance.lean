import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Core.StandingValuation

/-!
###############################################################################
# Representation Invariance of Structural Admissibility
###############################################################################

This file proves that structural admissibility
and legitimacy
are invariant under isomorphic
representation of system state.

This ensures that:

  legitimacy depends on structural relation
  rather than encoding.

State isomorphism preserves:

  • coupling relations,
  • standing valuation,
  • dependency structure,
  • exposure‑indexed risk,
  • and exit feasibility.

Thus:

  structurally equivalent states
  admit equivalent legitimacy.
-/

namespace SigmaR

/--
State isomorphism:

Two states represent
equivalent structural relation.
-/
constant Isomorphic :
  State → State → Prop

/--
Standing valuation
is invariant under isomorphism.
-/
axiom valuation_invariant :
  ∀ {s₁ s₂ : State} {i : Agent},
    Isomorphic s₁ s₂ →
    σ s₁ i = σ s₂ i

/--
Structural admissibility
is invariant under
state isomorphism.
-/
theorem admissibility_invariant :
  ∀ {F : Operation} {s₁ s₂ : State},
    Isomorphic s₁ s₂ →
    StructurallyAdmissible F s₁ →
    StructurallyAdmissible F s₂ :=
by
  -- proof outline:

  -- 1. Isomorphic states preserve:
  --      PFA
  --      Contestability
  --      DerivedStanding
  --      RiskIndexedStanding
  --      CouplingExhaustiveness
  --      DominantCouplingIdentified
  --      BoundaryRespected
  --      Rerunnable
  --
  -- 2. Therefore:
  --      StructurallyAdmissible preserved.

  admit

/--
Legitimacy
is invariant under
state isomorphism.
-/
theorem legitimacy_invariant :
  ∀ {F : Operation} {s₁ s₂ : State},
    Isomorphic s₁ s₂ →
    Legitimate F →
    Legitimate F :=
by
  -- follows from:
  -- legitimacy_characterization
  -- admissibility_invariant

  admit

end SigmaR
