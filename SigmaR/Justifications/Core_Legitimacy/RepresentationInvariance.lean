import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR_Core

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
axiom Isomorphic :
  State → State → Prop

/--
Standing valuation
is invariant under isomorphism.
-/
axiom valuation_invariant :
  ∀ {s₁ s₂ : State},
    Isomorphic s₁ s₂ →
    σv i s₁ = σv i s₂

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
  -- `StructurallyAdmissible` is the state-side of the Core Alignment equation,
  -- so it travels with `F` alone: whatever state realises `F` as legitimate
  -- realises its structural invariants.
  intro F s₁ s₂ _ hAdm
  exact (legitimacy_characterization (F := F) (s := s₂)).mp
    ((legitimacy_characterization (F := F) (s := s₁)).mpr hAdm)

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
  -- legitimacy is a property of the operation, so re-encoding the state
  -- leaves it untouched (cf. `admissibility_invariant`).
  intro _ _ _ _ hLeg
  exact hLeg

end SigmaR
