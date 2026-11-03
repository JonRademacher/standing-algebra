module

public import ICG.InteroperabilitySurface

@[expose] public section

namespace ICG

universe u

variable (geometry : InteroperabilityGeometry)

local instance : TopologicalSpace geometry.State := geometry.topology

namespace InteroperabilityGeometry

/-- A transition trajectory is a continuous path that remains inside the
declared interoperability surface. -/
structure TransitionTrajectory (source target : geometry.State) where
  path : ℝ → geometry.State
  continuous : ContinuousOn path (Set.Icc (0 : ℝ) 1)
  starts_at_source : path 0 = source
  ends_at_target : path 1 = target
  stays_on_surface :
    ∀ time ∈ Set.Icc (0 : ℝ) 1, path time ∈ geometry.surface

/-- A compatible state has boundary access when an admissible surface
trajectory reaches a boundary point. -/
structure BoundaryAccess (source : geometry.State) where
  source_compatible : source ∈ geometry.positiveRegion
  target : geometry.State
  target_on_boundary : target ∈ geometry.boundary
  trajectory : geometry.TransitionTrajectory source target

/-- Every access certificate explicitly ends at a transition configuration. -/
theorem boundary_access_reaches_boundary {source : geometry.State}
    (access : geometry.BoundaryAccess source) :
    access.trajectory.path 1 ∈ geometry.boundary := by
  rw [access.trajectory.ends_at_target]
  exact access.target_on_boundary

/-- The start of a boundary-access trajectory is compatible. -/
theorem boundary_access_starts_compatible {source : geometry.State}
    (access : geometry.BoundaryAccess source) :
    access.trajectory.path 0 ∈ geometry.positiveRegion := by
  rw [access.trajectory.starts_at_source]
  exact access.source_compatible

/-- An actually realized transition to the boundary supplies boundary access
by recording its trajectory, rather than merely asserting reachability. -/
def boundaryAccessOfTrajectory {source target : geometry.State}
    (hsource : source ∈ geometry.positiveRegion)
    (htarget : target ∈ geometry.boundary)
    (trajectory : geometry.TransitionTrajectory source target) :
    geometry.BoundaryAccess source :=
  ⟨hsource, target, htarget, trajectory⟩

/-- Two boundary points are joined by a boundary corridor when there is a
continuous trajectory whose every state remains on the boundary. -/
def BoundaryCorridor (left right : geometry.State) : Prop :=
  ∃ trajectory : geometry.TransitionTrajectory left right,
    ∀ time ∈ Set.Icc (0 : ℝ) 1,
      trajectory.path time ∈ geometry.boundary

/-- Path-connectedness of the boundary means every pair of its points admits
an admissible boundary corridor. This is stronger than mere connectedness. -/
def BoundaryPathConnected : Prop :=
  ∀ left, left ∈ geometry.boundary →
    ∀ right, right ∈ geometry.boundary →
      geometry.BoundaryCorridor left right

theorem boundary_path_connected_has_corridor
    (hconnected : geometry.BoundaryPathConnected)
    {left right : geometry.State}
    (hleft : left ∈ geometry.boundary)
    (hright : right ∈ geometry.boundary) :
    geometry.BoundaryCorridor left right :=
  hconnected left hleft right hright

/-- A corridor is an admissible continuous transition route between its
boundary endpoints. -/
theorem boundary_corridor_is_surface_trajectory
    {left right : geometry.State}
    (corridor : geometry.BoundaryCorridor left right) :
    ∃ trajectory : geometry.TransitionTrajectory left right,
      ∀ time ∈ Set.Icc (0 : ℝ) 1,
        trajectory.path time ∈ geometry.surface := by
  rcases corridor with ⟨trajectory, hboundary⟩
  refine ⟨trajectory, ?_⟩
  intro time htime
  exact geometry.boundary_subset_surface (hboundary time htime)

/-- Boundary-connected transition behavior can be used only when the
stronger path-connectivity certificate is available. -/
theorem boundary_points_have_transition_route
    (hconnected : geometry.BoundaryPathConnected)
    {left right : geometry.State}
    (hleft : left ∈ geometry.boundary)
    (hright : right ∈ geometry.boundary) :
    ∃ trajectory : geometry.TransitionTrajectory left right,
      ∀ time ∈ Set.Icc (0 : ℝ) 1,
        trajectory.path time ∈ geometry.boundary := by
  exact geometry.boundary_path_connected_has_corridor hconnected hleft hright

/-- The points of the boundary reachable from a compatible source through
surface-admissible trajectories. -/
def reachableBoundary (source : geometry.State) : Set geometry.State :=
  {target | target ∈ geometry.boundary ∧
    Nonempty (geometry.TransitionTrajectory source target)}

theorem reachable_boundary_subset_boundary (source : geometry.State) :
    geometry.reachableBoundary source ⊆ geometry.boundary := by
  intro target htarget
  exact htarget.1

theorem boundary_access_target_reachable {source : geometry.State}
    (access : geometry.BoundaryAccess source) :
    access.target ∈ geometry.reachableBoundary source := by
  exact ⟨access.target_on_boundary, ⟨access.trajectory⟩⟩

end InteroperabilityGeometry

end ICG
