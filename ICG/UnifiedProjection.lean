module

public import Mathlib.Data.Set.Basic

@[expose] public section

namespace ICG

/-- Coordinate architectures extracted from one shared interoperability state
space. Each coordinate may have its own value type, but no second state space
is introduced. -/
structure ICGProjectionFamily where
  State : Type*
  Recovery : Type*
  Diversity : Type*
  Resonance : Type*
  Reachability : Type*
  Pressure : Type*
  Representation : Type*
  Legitimacy : Type*
  Compatibility : Type*
  recovery : State → Recovery
  diversity : State → Diversity
  resonance : State → Resonance
  reachability : State → Reachability
  pressure : State → Pressure
  representation : State → Representation
  legitimacy : State → Legitimacy
  compatibility : State → Compatibility

namespace ICGProjectionFamily

variable (family : ICGProjectionFamily)

/-- The complete coordinate record associated with one underlying state. -/
structure GeometryCoordinates where
  recovery : family.Recovery
  diversity : family.Diversity
  resonance : family.Resonance
  reachability : family.Reachability
  pressure : family.Pressure
  representation : family.Representation
  legitimacy : family.Legitimacy
  compatibility : family.Compatibility

/-- All architectural projections are evaluated at the same state. -/
def fullGeometry (state : family.State) : family.GeometryCoordinates where
  recovery := family.recovery state
  diversity := family.diversity state
  resonance := family.resonance state
  reachability := family.reachability state
  pressure := family.pressure state
  representation := family.representation state
  legitimacy := family.legitimacy state
  compatibility := family.compatibility state

/-- Equality of the unified geometry entails equality in every coordinate. -/
theorem full_geometry_determines_all_coordinates
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.recovery left = family.recovery right ∧
      family.diversity left = family.diversity right ∧
      family.resonance left = family.resonance right ∧
      family.reachability left = family.reachability right ∧
      family.pressure left = family.pressure right ∧
      family.representation left = family.representation right ∧
      family.legitimacy left = family.legitimacy right ∧
      family.compatibility left = family.compatibility right := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · exact congrArg GeometryCoordinates.recovery same
  · exact congrArg GeometryCoordinates.diversity same
  · exact congrArg GeometryCoordinates.resonance same
  · exact congrArg GeometryCoordinates.reachability same
  · exact congrArg GeometryCoordinates.pressure same
  · exact congrArg GeometryCoordinates.representation same
  · exact congrArg GeometryCoordinates.legitimacy same
  · exact congrArg GeometryCoordinates.compatibility same

/-- Information available from one coordinate is coarser than the full
geometry: agreement on the full geometry forces agreement on that coordinate. -/
theorem recovery_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.recovery left = family.recovery right :=
  (family.full_geometry_determines_all_coordinates same).1

theorem diversity_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.diversity left = family.diversity right :=
  (family.full_geometry_determines_all_coordinates same).2.1

theorem resonance_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.resonance left = family.resonance right :=
  (family.full_geometry_determines_all_coordinates same).2.2.1

theorem reachability_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.reachability left = family.reachability right :=
  (family.full_geometry_determines_all_coordinates same).2.2.2.1

theorem pressure_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.pressure left = family.pressure right :=
  (family.full_geometry_determines_all_coordinates same).2.2.2.2.1

theorem representation_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.representation left = family.representation right :=
  (family.full_geometry_determines_all_coordinates same).2.2.2.2.2.1

theorem legitimacy_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.legitimacy left = family.legitimacy right :=
  (family.full_geometry_determines_all_coordinates same).2.2.2.2.2.2.1

theorem compatibility_projection_refines_full_geometry
    {left right : family.State}
    (same : family.fullGeometry left = family.fullGeometry right) :
    family.compatibility left = family.compatibility right :=
  (family.full_geometry_determines_all_coordinates same).2.2.2.2.2.2.2

end ICGProjectionFamily

/-- The admissibility filter induced by a declared collection of predicates. -/
def admissibleIntersection {State : Type*}
    (conditions : Set (State → Prop)) : Set State :=
  {state | ∀ condition ∈ conditions, condition state}

theorem admissible_intersection_subset_condition
    {State : Type*} {conditions : Set (State → Prop)}
    {condition : State → Prop}
    (condition_mem : condition ∈ conditions) :
    admissibleIntersection conditions ⊆ {state | condition state} := by
  intro state admissible
  exact admissible condition condition_mem

/-- A future trajectory is retained precisely when every state on it passes
the common admissibility filter. -/
def filteredTrajectory {Index State : Type*}
    (conditions : Set (State → Prop)) (trajectory : Index → State) : Prop :=
  ∀ index, trajectory index ∈ admissibleIntersection conditions

theorem filtered_trajectory_satisfies_each_condition
    {Index State : Type*}
    {conditions : Set (State → Prop)}
    {trajectory : Index → State}
    (condition : State → Prop) (condition_mem : condition ∈ conditions)
    (filtered : filteredTrajectory conditions trajectory) :
    ∀ index, condition (trajectory index) := by
  intro index
  exact filtered index condition condition_mem

end ICG
