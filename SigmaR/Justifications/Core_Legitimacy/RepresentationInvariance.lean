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

/-- The source model does not define the structure-preserving maps needed
for a nontrivial representation theorem. This relation is therefore an
explicit input to the preservation contract below. -/
axiom Isomorphic : State → State → Prop

/-- Data required to transport every component of structural admissibility
between isomorphic states. These preservation facts are not consequences of
the current bare `Isomorphic` predicate. -/
structure AdmissibilityPreservation (s₁ s₂ : State) : Prop where
  states_are_isomorphic : Isomorphic s₁ s₂
  pfa_preserved : PFA s₁ → PFA s₂
  contestability_preserved : Contestable s₁ → Contestable s₂
  frame_resolution_preserved : FrameResolved s₁ → FrameResolved s₂
  derived_standing_preserved : DerivedStanding s₁ → DerivedStanding s₂
  risk_indexed_standing_preserved :
    RiskIndexedStanding s₁ → RiskIndexedStanding s₂
  coupling_exhaustiveness_preserved :
    CouplingExhaustive s₁ → CouplingExhaustive s₂
  dominant_coupling_preserved :
    DominantCouplingIdentified s₁ → DominantCouplingIdentified s₂
  boundary_respect_preserved :
    BoundaryRespected s₁ → BoundaryRespected s₂
  rerunnability_preserved : Rerunnable s₁ → Rerunnable s₂

/--
Structural admissibility
is invariant under
state isomorphism.
-/
theorem admissibility_invariant :
  ∀ {F : Operation} {s₁ s₂ : State},
    AdmissibilityPreservation s₁ s₂ →
    StructurallyAdmissible F s₁ →
    StructurallyAdmissible F s₂ :=
by
  intro F s₁ s₂ preservation admissible
  rcases admissible with
    ⟨hadmissible, hpfa, hcontestable, hframe, hderived, hrisk, hcoupling,
      hdominant, hboundary, hrerunnable⟩
  exact ⟨hadmissible, preservation.pfa_preserved hpfa,
    preservation.contestability_preserved hcontestable,
    preservation.frame_resolution_preserved hframe,
    preservation.derived_standing_preserved hderived,
    preservation.risk_indexed_standing_preserved hrisk,
    preservation.coupling_exhaustiveness_preserved hcoupling,
    preservation.dominant_coupling_preserved hdominant,
    preservation.boundary_respect_preserved hboundary,
    preservation.rerunnability_preserved hrerunnable⟩

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
  intro F s₁ s₂ _ hlegitimate
  exact hlegitimate

end SigmaR
