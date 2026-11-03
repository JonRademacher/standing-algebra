module

public import ICG.InteroperabilitySurface

@[expose] public section

namespace ICG

universe u

/-- A constraint architecture consists of a state space, its topology, and
the complete family of predicates that determine admissibility. -/
structure ConstraintArchitecture where
  State : Type u
  topology : TopologicalSpace State
  constraints : Set (State → Prop)

namespace ConstraintArchitecture

variable (architecture : ConstraintArchitecture)

local instance : TopologicalSpace architecture.State := architecture.topology

/-- A state is admissible exactly when it satisfies every declared constraint. -/
def admissible (state : architecture.State) : Prop :=
  ∀ constraint ∈ architecture.constraints, constraint state

/-- A representation exposes a classification induced by an architecture. -/
structure Realization where
  classification : architecture.State → Prop
  classification_iff_admissible :
    ∀ state, classification state ↔ architecture.admissible state

/-- The boundary extracted from a classification is the common closure of
the classified and unclassified regions. -/
def classificationBoundary (classification : architecture.State → Prop) :
    Set architecture.State :=
  closure {state | classification state} ∩
    closure {state | ¬ classification state}

/-- Classification-equivalent representations have the same transition
boundary in the shared topological state space. -/
theorem classificationBoundary_congr
    {left right : architecture.State → Prop}
    (hclassification : ∀ state, left state ↔ right state) :
    architecture.classificationBoundary left =
      architecture.classificationBoundary right := by
  have hpositive :
      {state | left state} = {state | right state} := by
    ext state
    exact hclassification state
  have hnegative :
      {state | ¬ left state} = {state | ¬ right state} := by
    ext state
    simp [hclassification state]
  simp [classificationBoundary, hpositive, hnegative]

/-- Any two realizations of one constraint architecture induce identical
classifications and therefore identical boundaries. -/
theorem realizations_have_same_boundary
    (compatibility interoperability : architecture.Realization) :
    architecture.classificationBoundary compatibility.classification =
      architecture.classificationBoundary interoperability.classification := by
  apply architecture.classificationBoundary_congr
  intro state
  rw [compatibility.classification_iff_admissible state,
    interoperability.classification_iff_admissible state]

/-- Boundary membership is invariant under replacing one realization by
another representation of the same architecture. -/
theorem boundary_membership_representation_invariant
    (compatibility interoperability : architecture.Realization)
    (state : architecture.State) :
    state ∈ architecture.classificationBoundary compatibility.classification ↔
      state ∈ architecture.classificationBoundary interoperability.classification := by
  rw [architecture.realizations_have_same_boundary]

/-- A constraint family induces a canonical admissibility realization. -/
def admissibilityRealization : architecture.Realization where
  classification := architecture.admissible
  classification_iff_admissible := fun _ => Iff.rfl

end ConstraintArchitecture

namespace InteroperabilityGeometry

variable (geometry : InteroperabilityGeometry)

local instance : TopologicalSpace geometry.State := geometry.topology

/-- The interoperability geometry's compatible region is a realization of
the corresponding singleton-constraint architecture. -/
def constraintArchitecture : ConstraintArchitecture where
  State := geometry.State
  topology := geometry.topology
  constraints := {geometry.satisfiesConstraints}

theorem singleton_architecture_admissibility (state : geometry.State) :
    geometry.constraintArchitecture.admissible state ↔
      geometry.satisfiesConstraints state := by
  change (∀ constraint ∈
      ({geometry.satisfiesConstraints} : Set (geometry.State → Prop)),
      constraint state) ↔ geometry.satisfiesConstraints state
  constructor
  · intro hadmissible
    exact hadmissible geometry.satisfiesConstraints (by simp)
  · intro hstate constraint hconstraint
    change constraint ∈
      ({geometry.satisfiesConstraints} : Set (geometry.State → Prop)) at hconstraint
    have hconstraint' : constraint = geometry.satisfiesConstraints :=
      Set.mem_singleton_iff.mp hconstraint
    subst constraint
    exact hstate

/-- The boundary extracted from the constraint realization agrees with the
boundary already defined by `InteroperabilityGeometry`. -/
theorem constraint_boundary_eq :
    geometry.constraintArchitecture.classificationBoundary
        geometry.constraintArchitecture.admissible =
      geometry.boundary := by
  change geometry.constraintArchitecture.classificationBoundary
      geometry.constraintArchitecture.admissible =
    geometry.constraintArchitecture.classificationBoundary
      geometry.satisfiesConstraints
  apply geometry.constraintArchitecture.classificationBoundary_congr
  intro state
  exact geometry.singleton_architecture_admissibility state

end InteroperabilityGeometry

/-- A homeomorphism that preserves the admissibility classification carries
the entire topological transition boundary to the corresponding boundary. -/
theorem homeomorph_maps_classification_boundary
    {State₁ : Type u} {State₂ : Type u}
    [TopologicalSpace State₁] [TopologicalSpace State₂]
    (equiv : State₁ ≃ₜ State₂)
    {classification₁ : State₁ → Prop} {classification₂ : State₂ → Prop}
    (hclassification : ∀ state, classification₂ (equiv state) ↔
      classification₁ state) :
    equiv '' (closure {state | classification₁ state} ∩
        closure {state | ¬ classification₁ state}) =
      closure {state | classification₂ state} ∩
        closure {state | ¬ classification₂ state} := by
  have hpositive :
      equiv '' {state | classification₁ state} =
        {state | classification₂ state} := by
    ext state
    constructor
    · rintro ⟨source, hsource, rfl⟩
      exact (hclassification source).mpr hsource
    · intro hstate
      refine ⟨equiv.symm state, ?_, equiv.apply_symm_apply state⟩
      exact (hclassification (equiv.symm state)).mp (by simpa using hstate)
  have hnegative :
      equiv '' {state | ¬ classification₁ state} =
        {state | ¬ classification₂ state} := by
    ext state
    constructor
    · rintro ⟨source, hsource, rfl⟩
      exact fun hclassified => hsource ((hclassification source).mp hclassified)
    · intro hstate
      refine ⟨equiv.symm state, ?_, equiv.apply_symm_apply state⟩
      intro hclassified
      exact hstate (by
        simpa using (hclassification (equiv.symm state)).mpr hclassified)
  rw [Set.image_inter equiv.injective, equiv.image_closure, equiv.image_closure,
    hpositive, hnegative]

end ICG
