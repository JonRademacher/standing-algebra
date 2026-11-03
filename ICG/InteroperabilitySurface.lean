module

public import Mathlib.Topology.Basic
public import Mathlib.Topology.MetricSpace.HausdorffDistance
public import Mathlib.Topology.Order.IntermediateValue

@[expose] public section

namespace ICG

universe u

/-- The source's interoperability surface starts from a state space, a fixed
family of governing constraints, and a topology used to define its boundary. -/
structure InteroperabilityGeometry where
  State : Type u
  topology : TopologicalSpace State
  satisfiesConstraints : State → Prop

namespace InteroperabilityGeometry

variable (geometry : InteroperabilityGeometry)

local instance : TopologicalSpace geometry.State := geometry.topology

/-- Configurations satisfying every governing interoperability constraint. -/
def positiveRegion : Set geometry.State :=
  {state | geometry.satisfiesConstraints state}

/-- Configurations violating at least one governing interoperability constraint. -/
def negativeRegion : Set geometry.State :=
  {state | ¬ geometry.satisfiesConstraints state}

/-- The transition region is the intersection of the closures of the two regions. -/
def boundary : Set geometry.State :=
  closure geometry.positiveRegion ∩ closure geometry.negativeRegion

/-- The surface records compatible, incompatible, and transition configurations. -/
def surface : Set geometry.State :=
  geometry.positiveRegion ∪ geometry.negativeRegion ∪ geometry.boundary

/-- A boundary point is accessible from both compatibility classifications in
every neighborhood. -/
def boundaryAccessibleAt (state : geometry.State) : Prop :=
  ∀ neighborhood ∈ nhds state,
    (neighborhood ∩ geometry.positiveRegion).Nonempty ∧
      (neighborhood ∩ geometry.negativeRegion).Nonempty

theorem boundary_iff_neighborhood_mixing (state : geometry.State) :
    state ∈ geometry.boundary ↔ geometry.boundaryAccessibleAt state := by
  rw [boundary, Set.mem_inter_iff, mem_closure_iff_nhds, mem_closure_iff_nhds]
  unfold boundaryAccessibleAt
  constructor
  · intro h neighborhood hneighborhood
    exact ⟨h.1 neighborhood hneighborhood, h.2 neighborhood hneighborhood⟩
  · intro h
    exact ⟨fun neighborhood hneighborhood => (h neighborhood hneighborhood).1,
      fun neighborhood hneighborhood => (h neighborhood hneighborhood).2⟩

theorem stable_in_positive_interior {state : geometry.State}
    (hinterior : state ∈ interior geometry.positiveRegion) :
    state ∉ geometry.boundary := by
  intro hboundary
  change state ∈ closure geometry.positiveRegion ∩
    closure geometry.negativeRegion at hboundary
  have hneighborhood : geometry.positiveRegion ∈ nhds state :=
    mem_interior_iff_mem_nhds.mp hinterior
  rcases (mem_closure_iff_nhds.mp hboundary.2)
      geometry.positiveRegion hneighborhood with ⟨point, hpoint⟩
  exact hpoint.2 hpoint.1

theorem stable_in_negative_interior {state : geometry.State}
    (hinterior : state ∈ interior geometry.negativeRegion) :
    state ∉ geometry.boundary := by
  intro hboundary
  change state ∈ closure geometry.positiveRegion ∩
    closure geometry.negativeRegion at hboundary
  have hneighborhood : geometry.negativeRegion ∈ nhds state :=
    mem_interior_iff_mem_nhds.mp hinterior
  rcases (mem_closure_iff_nhds.mp hboundary.1)
      geometry.negativeRegion hneighborhood with ⟨point, hpoint⟩
  exact hpoint.1 hpoint.2

/-- Every point outside the transition boundary is locally stable in one of
the two complementary compatibility regions. -/
theorem outside_boundary_interior_union :
    Set.univ \ geometry.boundary ⊆
      interior geometry.positiveRegion ∪ interior geometry.negativeRegion := by
  intro state hstate
  have hnotBoundary :
      ¬ (state ∈ closure geometry.positiveRegion ∧
        state ∈ closure geometry.negativeRegion) := by
    simpa [boundary] using hstate
  rcases not_and_or.mp hnotBoundary with hpositive | hnegative
  · right
    rw [mem_interior_iff_mem_nhds]
    have hnotClosure :
        ¬ ∀ neighborhood ∈ nhds state,
          (neighborhood ∩ geometry.positiveRegion).Nonempty := by
      simpa only [mem_closure_iff_nhds] using hpositive
    push Not at hnotClosure
    obtain ⟨neighborhood, hneighborhood, hdisjoint⟩ := hnotClosure
    have hsubset : neighborhood ⊆ geometry.negativeRegion := by
      intro point hpoint
      change ¬ geometry.satisfiesConstraints point
      intro hcompatible
      have hnonempty :
          (neighborhood ∩ geometry.positiveRegion).Nonempty :=
        ⟨point, ⟨hpoint, hcompatible⟩⟩
      rw [hdisjoint] at hnonempty
      simp at hnonempty
    exact Filter.mem_of_superset hneighborhood hsubset
  · left
    rw [mem_interior_iff_mem_nhds]
    have hnotClosure :
        ¬ ∀ neighborhood ∈ nhds state,
          (neighborhood ∩ geometry.negativeRegion).Nonempty := by
      simpa only [mem_closure_iff_nhds] using hnegative
    push Not at hnotClosure
    obtain ⟨neighborhood, hneighborhood, hdisjoint⟩ := hnotClosure
    have hsubset : neighborhood ⊆ geometry.positiveRegion := by
      intro point hpoint
      change geometry.satisfiesConstraints point
      by_contra hcompatible
      have hnonempty :
          (neighborhood ∩ geometry.negativeRegion).Nonempty :=
        ⟨point, ⟨hpoint, hcompatible⟩⟩
      rw [hdisjoint] at hnonempty
      simp at hnonempty
    exact Filter.mem_of_superset hneighborhood hsubset

/-- A continuous path between compatible and incompatible configurations
necessarily meets the interoperability boundary. -/
theorem continuous_path_meets_boundary
    {path : ℝ → geometry.State}
    (hpath : ContinuousOn path (Set.Icc (0 : ℝ) 1))
    (hstart : path 0 ∈ geometry.positiveRegion)
    (hend : path 1 ∈ geometry.negativeRegion) :
    ∃ time ∈ Set.Icc (0 : ℝ) 1, path time ∈ geometry.boundary := by
  let interval := Set.Icc (0 : ℝ) 1
  let trajectory := path '' interval
  have htrajectory : IsPreconnected trajectory :=
    isPreconnected_Icc.image path hpath
  have hmeetsPositive : (trajectory ∩ geometry.positiveRegion).Nonempty :=
    ⟨path 0, ⟨⟨0, by simp [interval], rfl⟩, hstart⟩⟩
  have hmeetsNegative : (trajectory ∩ geometry.negativeRegion).Nonempty :=
    ⟨path 1, ⟨⟨1, by simp [interval], rfl⟩, hend⟩⟩
  rcases hmeetsPositive with ⟨positiveState, ⟨hpositiveTrajectory, hpositive⟩⟩
  rcases hmeetsNegative with ⟨negativeState, ⟨hnegativeTrajectory, hnegative⟩⟩
  by_contra hnoBoundary
  have hsubsetInteriors :
      trajectory ⊆ interior geometry.positiveRegion ∪
        interior geometry.negativeRegion := by
    intro state hstate
    apply geometry.outside_boundary_interior_union
    refine ⟨Set.mem_univ state, ?_⟩
    intro hboundary
    apply hnoBoundary
    rcases hstate with ⟨time, htime, rfl⟩
    exact ⟨time, htime, hboundary⟩
  have hdisjointInteriors :
      Disjoint (interior geometry.positiveRegion)
        (interior geometry.negativeRegion) := by
    rw [Set.disjoint_left]
    intro state hpositive hnegative
    exact (interior_subset hnegative) (interior_subset hpositive)
  rcases htrajectory.subset_or_subset isOpen_interior isOpen_interior
      hdisjointInteriors hsubsetInteriors with himagePositive | himageNegative
  · exact hnegative (interior_subset (himagePositive hnegativeTrajectory))
  · exact (interior_subset (himageNegative hpositiveTrajectory)) hpositive

/-- Metric accessibility records the distance from a configuration to the
interoperability transition boundary. -/
noncomputable def boundaryAccessibility [PseudoMetricSpace geometry.State]
    (state : geometry.State) : ℝ :=
  Metric.infDist state geometry.boundary

theorem boundaryAccessibility_nonnegative [PseudoMetricSpace geometry.State]
    (state : geometry.State) : 0 ≤ geometry.boundaryAccessibility state :=
  Metric.infDist_nonneg

theorem positive_negative_disjoint :
    Disjoint geometry.positiveRegion geometry.negativeRegion := by
  rw [Set.disjoint_left]
  intro state hpositive hnegative
  exact hnegative hpositive

theorem regions_exhaust_state_space :
    geometry.positiveRegion ∪ geometry.negativeRegion = Set.univ := by
  ext state
  by_cases h : geometry.satisfiesConstraints state <;>
    simp [positiveRegion, negativeRegion, h]

/-- The source's surface is exactly the union of its three named regions. -/
theorem surface_partition :
    geometry.surface =
      geometry.positiveRegion ∪ geometry.negativeRegion ∪ geometry.boundary := rfl

theorem surface_eq_univ : geometry.surface = Set.univ := by
  rw [surface, regions_exhaust_state_space]
  simp

theorem positive_subset_surface :
    geometry.positiveRegion ⊆ geometry.surface := by
  intro state hstate
  exact Or.inl (Or.inl hstate)

theorem negative_subset_surface :
    geometry.negativeRegion ⊆ geometry.surface := by
  intro state hstate
  exact Or.inl (Or.inr hstate)

theorem boundary_subset_surface :
    geometry.boundary ⊆ geometry.surface := by
  intro state hstate
  exact Or.inr hstate

/-- A resonant architecture is localized by a proof that its configurations
preserve the governing interoperability constraints. -/
structure ResonanceArchitecture where
  configurations : Set geometry.State
  constraint_preserving : configurations ⊆ geometry.positiveRegion

theorem resonance_localization (architecture : geometry.ResonanceArchitecture) :
    architecture.configurations ⊆ geometry.positiveRegion :=
  architecture.constraint_preserving

/-- An emergent architecture is localized by its inherited compatibility proof. -/
structure EmergentArchitecture where
  configurations : Set geometry.State
  compatibility_inherited : configurations ⊆ geometry.positiveRegion

theorem emergence_localization (architecture : geometry.EmergentArchitecture) :
    architecture.configurations ⊆ geometry.positiveRegion :=
  architecture.compatibility_inherited

/-- A realization map is latent when distinct compatibility structures can
produce the same realization. -/
structure LatentRealization (Compatibility Realization : Type*) where
  realize : Compatibility → Realization
  latentPair : Compatibility × Compatibility
  distinct : latentPair.1 ≠ latentPair.2
  sameRealization : realize latentPair.1 = realize latentPair.2

/-- The compatibility structures hidden beneath a particular realization. -/
def realizationFiber {Compatibility Realization : Type*}
    (realize : Compatibility → Realization) (realization : Realization) :
    Set Compatibility :=
  {compatibility | realize compatibility = realization}

theorem latent_pair_belongs_to_same_fiber
    {Compatibility Realization : Type*}
    (latent : LatentRealization Compatibility Realization) :
    latent.latentPair.1 ∈ realizationFiber latent.realize
        (latent.realize latent.latentPair.2) ∧
      latent.latentPair.2 ∈ realizationFiber latent.realize
        (latent.realize latent.latentPair.2) := by
  constructor
  · change latent.realize latent.latentPair.1 =
      latent.realize latent.latentPair.2
    exact latent.sameRealization
  · rfl

theorem latent_pair_has_same_realization
    {Compatibility Realization : Type*}
    (latent : LatentRealization Compatibility Realization) :
    latent.realize latent.latentPair.1 = latent.realize latent.latentPair.2 :=
  latent.sameRealization

/-- The latent realization fiber over a boundary configuration. -/
def boundaryFiber {Compatibility : Type*}
    (realize : Compatibility → geometry.State) (state : geometry.State) :
    Set Compatibility :=
  {compatibility | compatibility ∈ realizationFiber realize state ∧
    state ∈ geometry.boundary}

/-- A non-injective realization over a boundary point yields distinct
compatible structures in that point's boundary fiber. -/
theorem boundary_fiber_contains_latent_pair
    {Compatibility : Type*}
    (latent : LatentRealization Compatibility geometry.State)
    (hboundary : latent.realize latent.latentPair.1 ∈ geometry.boundary) :
    latent.latentPair.1 ∈
        geometry.boundaryFiber latent.realize
          (latent.realize latent.latentPair.1) ∧
      latent.latentPair.2 ∈
        geometry.boundaryFiber latent.realize
          (latent.realize latent.latentPair.1) ∧
      latent.latentPair.1 ≠ latent.latentPair.2 := by
  refine ⟨?_, ?_, latent.distinct⟩
  · exact ⟨rfl, hboundary⟩
  · exact ⟨latent.sameRealization.symm, hboundary⟩

/-- Objects and operations induced by the interoperability surface. -/
structure InducedArchitecture where
  objects : Set (Set geometry.State)
  objects_within_surface :
    ∀ object ∈ objects, object ⊆ geometry.surface
  operations : Set (geometry.State → geometry.State)
  operations_preserve_surface :
    ∀ operation ∈ operations, ∀ ⦃state⦄, state ∈ geometry.surface →
      operation state ∈ geometry.surface

theorem induced_object_within_surface
    (architecture : geometry.InducedArchitecture)
    {object : Set geometry.State} (hobject : object ∈ architecture.objects) :
    object ⊆ geometry.surface :=
  architecture.objects_within_surface object hobject

theorem induced_operation_preserves_surface
    (architecture : geometry.InducedArchitecture)
    {operation : geometry.State → geometry.State}
    (hoperation : operation ∈ architecture.operations)
    {state : geometry.State} (hstate : state ∈ geometry.surface) :
    operation state ∈ geometry.surface :=
  architecture.operations_preserve_surface operation hoperation hstate

/-- A certificate that the five geometries named in the source are induced
from one common interoperability surface. The source's unification conclusion
is conditional on these five induction certificates. -/
structure UnificationCertificate where
  recovery : geometry.InducedArchitecture
  diversity : geometry.InducedArchitecture
  resonance : geometry.InducedArchitecture
  emergence : geometry.InducedArchitecture
  latent : geometry.InducedArchitecture

theorem common_surface_generates_five_geometries
    (certificate : geometry.UnificationCertificate) :
    (∀ object ∈ certificate.recovery.objects,
      object ⊆ geometry.surface) ∧
      (∀ object ∈ certificate.diversity.objects,
        object ⊆ geometry.surface) ∧
      (∀ object ∈ certificate.resonance.objects,
        object ⊆ geometry.surface) ∧
      (∀ object ∈ certificate.emergence.objects,
        object ⊆ geometry.surface) ∧
      (∀ object ∈ certificate.latent.objects,
        object ⊆ geometry.surface) :=
  ⟨certificate.recovery.objects_within_surface,
    certificate.diversity.objects_within_surface,
    certificate.resonance.objects_within_surface,
    certificate.emergence.objects_within_surface,
    certificate.latent.objects_within_surface⟩

end InteroperabilityGeometry

end ICG
