module

public import Mathlib.Topology.MetricSpace.HausdorffDistance

@[expose] public section

namespace ICG

universe u

/-- A discrete structural evolution law on a realization space. -/
structure DiscreteDynamics (State : Type u) where
  evolve : State → State

namespace DiscreteDynamics

variable {State : Type u} (dynamics : DiscreteDynamics State)

/-- The state reached after a fixed number of evolution steps. -/
def orbit (initial : State) : Nat → State
  | 0 => initial
  | n + 1 => dynamics.evolve (orbit initial n)

theorem orbit_succ (initial : State) (n : Nat) :
    dynamics.orbit initial (n + 1) =
      dynamics.evolve (dynamics.orbit initial n) := rfl

/-- A region is forward invariant when evolution never leaves it. -/
def ForwardInvariant (region : Set State) : Prop :=
  ∀ ⦃x⦄, x ∈ region → dynamics.evolve x ∈ region

theorem orbit_mem_of_forwardInvariant (region : Set State)
    (hinvariant : dynamics.ForwardInvariant region) {initial : State}
    (hinitial : initial ∈ region) (n : Nat) :
    dynamics.orbit initial n ∈ region := by
  induction n with
  | zero =>
      exact hinitial
  | succ n ih =>
      rw [orbit_succ]
      exact hinvariant ih

theorem orbit_const_of_fixedPoint {initial : State}
    (hfixed : dynamics.evolve initial = initial) (n : Nat) :
    dynamics.orbit initial n = initial := by
  induction n with
  | zero =>
      rfl
  | succ n ih =>
      rw [orbit_succ, ih, hfixed]

end DiscreteDynamics

/-- A closed invariant region attracting a specified collection of initial states. -/
structure Attractor (State : Type u) [PseudoMetricSpace State]
    (dynamics : DiscreteDynamics State) where
  region : Set State
  nonempty : region.Nonempty
  closed : IsClosed region
  invariant : dynamics.ForwardInvariant region
  basin : Set State
  basin_contains_region : region ⊆ basin
  attracts : ∀ x ∈ basin,
    Filter.Tendsto (fun n : Nat => Metric.infDist (dynamics.orbit x n) region)
      Filter.atTop (nhds 0)

/-- A parameterized family of evolution rules, used to state bifurcation questions. -/
structure DynamicsFamily (Parameter : Type u) (State : Type u) where
  evolve : Parameter → State → State

/-- The orbit of a parameterized dynamics at a fixed parameter. -/
def parameterOrbit {Parameter State : Type u} (family : DynamicsFamily Parameter State)
    (parameter : Parameter) (initial : State) : Nat → State
  | 0 => initial
  | n + 1 => family.evolve parameter (parameterOrbit family parameter initial n)

end ICG
