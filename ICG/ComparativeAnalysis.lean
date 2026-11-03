module

public import ICG.UnifiedProjection
public import Mathlib.Basic.Real.Basic

@[expose] public section

namespace ICG

universe u v w

/-- Every analytical method in a comparison is evaluated against the same
evidence value; its encoding may differ by method. -/
def PortfolioOutput (Method : Type u) (Evidence : Type v) (Conclusion : Type w)
    (methods : Set Method)
    (output : Method → Evidence → Set Conclusion)
    (evidence : Evidence) : Set Conclusion :=
  {conclusion | ∃ method, method ∈ methods ∧ conclusion ∈ output method evidence}

/-- An architecture may explain the evidence without satisfying cross-projection
consistency. -/
structure ReconstructionFamily (Architecture : Type u) (Evidence : Type v) where
  explains : Architecture → Evidence → Prop
  jointlyConsistent : Architecture → Prop

namespace ReconstructionFamily

variable {Architecture : Type u} {Evidence : Type v}
  (family : ReconstructionFamily Architecture Evidence)

def consistentWith (evidence : Evidence) : Set Architecture :=
  {architecture | family.explains architecture evidence}

def jointlyAdmissible (evidence : Evidence) : Set Architecture :=
  {architecture | family.explains architecture evidence ∧
    family.jointlyConsistent architecture}

theorem joint_filter_subset (evidence : Evidence) :
    family.jointlyAdmissible evidence ⊆ family.consistentWith evidence := by
  intro architecture h
  exact h.1

theorem joint_filter_strict
    (evidence : Evidence)
    (excluded : Architecture)
    (hexplains : family.explains excluded evidence)
    (hinconsistent : ¬ family.jointlyConsistent excluded) :
    family.jointlyAdmissible evidence ⊂ family.consistentWith evidence := by
  refine ⟨family.joint_filter_subset evidence, ?_⟩
  intro hsubset
  have hexcluded : excluded ∈ family.consistentWith evidence := hexplains
  have hjoint : excluded ∈ family.jointlyAdmissible evidence :=
    hsubset hexcluded
  exact hinconsistent hjoint.2

end ReconstructionFamily

/-- The seven named trajectory conditions are separate inputs; joint
admissibility requires all of them and does not rank the trajectories. -/
structure TrajectoryConditions (Trajectory : Type u) where
  compatible : Trajectory → Prop
  recoverable : Trajectory → Prop
  energyAdmissible : Trajectory → Prop
  pressureAdmissible : Trajectory → Prop
  represented : Trajectory → Prop
  legitimate : Trajectory → Prop
  resonant : Trajectory → Prop

namespace TrajectoryConditions

variable {Trajectory : Type u} (conditions : TrajectoryConditions Trajectory)

def jointlyAdmissible (trajectory : Trajectory) : Prop :=
  conditions.compatible trajectory ∧
    conditions.recoverable trajectory ∧
    conditions.energyAdmissible trajectory ∧
    conditions.pressureAdmissible trajectory ∧
    conditions.represented trajectory ∧
    conditions.legitimate trajectory ∧
    conditions.resonant trajectory

theorem joint_membership_iff (trajectory : Trajectory) :
    conditions.jointlyAdmissible trajectory ↔
      conditions.compatible trajectory ∧
        conditions.recoverable trajectory ∧
        conditions.energyAdmissible trajectory ∧
        conditions.pressureAdmissible trajectory ∧
        conditions.represented trajectory ∧
        conditions.legitimate trajectory ∧
        conditions.resonant trajectory :=
  Iff.rfl

end TrajectoryConditions

/-- A declared coordinate-wise preference profile for Pareto comparison.
The profile makes directionality and strict improvement explicit. -/
structure ParetoProfile (Trajectory : Type u) (Criterion : Type v) where
  noWorse : Trajectory → Trajectory → Criterion → Prop
  strictlyBetter : Trajectory → Trajectory → Criterion → Prop

namespace ParetoProfile

variable {Trajectory : Type u} {Criterion : Type v}
  (profile : ParetoProfile Trajectory Criterion)

def Dominates (left right : Trajectory) : Prop :=
  (∀ criterion, profile.noWorse left right criterion) ∧
    (∃ criterion, profile.strictlyBetter left right criterion)

def ParetoSurvivor (landscape : Set Trajectory) (trajectory : Trajectory) : Prop :=
  trajectory ∈ landscape ∧
    ¬ ∃ competitor, competitor ∈ landscape ∧ profile.Dominates competitor trajectory

theorem dominated_not_survivor (landscape : Set Trajectory)
    {trajectory competitor : Trajectory}
    (hcompetitor : competitor ∈ landscape)
    (hdominates : profile.Dominates competitor trajectory) :
    ¬ profile.ParetoSurvivor landscape trajectory := by
  intro hsurvivor
  exact hsurvivor.2 ⟨competitor, hcompetitor, hdominates⟩

def paretoFilter (landscape : Set Trajectory) : Set Trajectory :=
  {trajectory | profile.ParetoSurvivor landscape trajectory}

theorem paretoFilter_subset (landscape : Set Trajectory) :
    profile.paretoFilter landscape ⊆ landscape := by
  intro trajectory h
  exact h.1

end ParetoProfile

/-- A scalar "best" claim requires an explicitly supplied ranking relation;
the trajectory conditions and vector criteria alone do not provide one. -/
structure ScalarDecisionRule (Trajectory : Type u) where
  atLeastAsGood : Trajectory → Trajectory → Prop

/-- A simple two-criterion example with two incomparable Pareto survivors. -/
def exampleParetoProfile : ParetoProfile Bool Bool where
  noWorse left right criterion :=
    (if criterion then (if left then 1 else 0) else (if left then 0 else 1)) ≥
      (if criterion then (if right then 1 else 0) else (if right then 0 else 1))
  strictlyBetter left right criterion :=
    (if criterion then (if left then 1 else 0) else (if left then 0 else 1)) >
      (if criterion then (if right then 1 else 0) else (if right then 0 else 1))

theorem both_example_trajectories_are_pareto_survivors :
    exampleParetoProfile.ParetoSurvivor
        (Set.univ : Set Bool) false ∧
      exampleParetoProfile.ParetoSurvivor
        (Set.univ : Set Bool) true := by
  constructor
  · refine ⟨Set.mem_univ _, ?_⟩
    rintro ⟨competitor, _, hdominates⟩
    cases competitor with
    | false =>
        rcases hdominates.2 with ⟨criterion, hbetter⟩
        cases criterion <;>
          norm_num [ParetoProfile.Dominates, exampleParetoProfile] at hbetter
    | true =>
        have hnoWorse := hdominates.1 false
        norm_num [ParetoProfile.Dominates, exampleParetoProfile] at hnoWorse
  · refine ⟨Set.mem_univ _, ?_⟩
    rintro ⟨competitor, _, hdominates⟩
    cases competitor with
    | false =>
        have hnoWorse := hdominates.1 true
        norm_num [ParetoProfile.Dominates, exampleParetoProfile] at hnoWorse
    | true =>
        rcases hdominates.2 with ⟨criterion, hbetter⟩
        cases criterion <;>
          norm_num [ParetoProfile.Dominates, exampleParetoProfile] at hbetter

/-- If an intervention improves an outcome while leaving the obstruction
architecture unchanged, that improvement is not structural recovery under
the declared criterion that recovery changes the obstruction. -/
def StructuralRecovery {State : Type u} {Obstruction : Type v}
    (obstruction : State → Obstruction) (initial final : State) : Prop :=
  obstruction initial ≠ obstruction final

theorem invariant_obstruction_is_not_recovery
    {State : Type u} {Obstruction : Type v}
    (obstruction : State → Obstruction) (initial final : State)
    (hinvariant : obstruction initial = obstruction final) :
    ¬ StructuralRecovery obstruction initial final := by
  unfold StructuralRecovery
  intro hchanged
  exact hchanged hinvariant

/-- Conditional integrated gain: joint consistency changes the surviving
family when an isolated-method survivor violates a cross-projection condition,
while another candidate satisfies all joint conditions. -/
theorem conditional_integrated_gain
    {Architecture : Type u} {Evidence : Type v}
    (family : ReconstructionFamily Architecture Evidence)
    (evidence : Evidence)
    (excluded alternative : Architecture)
    (hexcludedExplains : family.explains excluded evidence)
    (hexcludedInconsistent : ¬ family.jointlyConsistent excluded)
    (haltExplains : family.explains alternative evidence)
    (haltJointlyConsistent : family.jointlyConsistent alternative) :
    family.jointlyAdmissible evidence ⊂ family.consistentWith evidence ∧
      (alternative ∈ family.jointlyAdmissible evidence) := by
  refine ⟨family.joint_filter_strict evidence excluded
    hexcludedExplains hexcludedInconsistent, ?_⟩
  exact ⟨haltExplains, haltJointlyConsistent⟩

end ICG
