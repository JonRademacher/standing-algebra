module

public import Mathlib.Data.Finset.Card
public import ICG.ConstraintArchitectureBridge

@[expose] public section

namespace ICG

/-- A finite family of constraints, together with the boundary it generates. -/
structure BoundaryGeneratorSystem (State Constraint : Type*) where
  boundaryOf : Finset Constraint → Set State

namespace BoundaryGeneratorSystem

variable {State Constraint : Type*}

/-- A constraint family generates a target boundary when its extracted
boundary is exactly that target. -/
def Generates (system : BoundaryGeneratorSystem State Constraint)
    (constraints : Finset Constraint) (target : Set State) : Prop :=
  system.boundaryOf constraints = target

/-- Every finite generating family contains an inclusion-minimal generating
subfamily. Finiteness is the hypothesis that makes the source's minimality
claim constructive without assuming an infinite minimal basis. -/
theorem exists_minimal_generating_subfamily
    (system : BoundaryGeneratorSystem State Constraint)
    (available : Finset Constraint) (target : Set State)
    (hgenerates : system.Generates available target) :
    ∃ minimal ⊆ available,
      system.Generates minimal target ∧
        ∀ smaller, smaller ⊂ minimal →
          ¬ system.Generates smaller target := by
  classical
  have auxiliary :
      ∀ n : ℕ, ∀ constraints : Finset Constraint,
        constraints.card = n →
          system.Generates constraints target →
            ∃ minimal ⊆ constraints,
              system.Generates minimal target ∧
                ∀ smaller, smaller ⊂ minimal →
                  ¬ system.Generates smaller target := by
    intro n
    induction n using Nat.strong_induction_on with
    | h n ih =>
      intro constraints hcard hconstraints
      by_cases hsmaller :
          ∃ candidate, candidate ⊂ constraints ∧
            system.Generates candidate target
      · obtain ⟨candidate, hsubset, hcandidate⟩ := hsmaller
        have hcard_lt : candidate.card < n := by
          rw [← hcard]
          exact Finset.card_lt_card hsubset
        obtain ⟨minimal, hminimal_subset, hminimal_generates,
          hminimality⟩ :=
          ih candidate.card hcard_lt candidate rfl hcandidate
        refine ⟨minimal, Finset.Subset.trans hminimal_subset hsubset.1,
          hminimal_generates, hminimality⟩
      · refine ⟨constraints, Finset.Subset.rfl, hconstraints, ?_⟩
        intro smaller hproper hgenerates
        exact hsmaller ⟨smaller, hproper, hgenerates⟩
  exact auxiliary available.card available rfl hgenerates

end BoundaryGeneratorSystem

namespace ConstraintArchitecture

variable (architecture : ConstraintArchitecture)

local instance : TopologicalSpace architecture.State := architecture.topology

/-- Add one predicate to the declared constraint family. -/
def addConstraint (constraint : architecture.State → Prop) :
    ConstraintArchitecture where
  State := architecture.State
  topology := architecture.topology
  constraints := insert constraint architecture.constraints

/-- A constraint satisfied by every state does not change admissibility. -/
theorem admissibility_unchanged_by_universal_constraint
    (constraint : architecture.State → Prop)
    (huniversal : ∀ state, constraint state)
    (state : architecture.State) :
    (architecture.addConstraint constraint).admissible state ↔
      architecture.admissible state := by
  change (∀ added ∈ insert constraint architecture.constraints,
      added state) ↔
    (∀ existing ∈ architecture.constraints, existing state)
  constructor
  · intro hadditionallyAdmissible existing hexisting
    exact hadditionallyAdmissible existing
      (Set.mem_insert_of_mem constraint hexisting)
  · intro hadmissible added hadded
    rcases Set.mem_insert_iff.mp hadded with rfl | hexisting
    · exact huniversal state
    · exact hadmissible added hexisting

/-- Adding a universally satisfied constraint leaves the boundary unchanged. -/
theorem boundary_unchanged_by_universal_constraint
    (constraint : architecture.State → Prop)
    (huniversal : ∀ state, constraint state) :
    architecture.classificationBoundary architecture.admissible =
      architecture.classificationBoundary
        (architecture.addConstraint constraint).admissible := by
  apply architecture.classificationBoundary_congr
  intro state
  exact (architecture.admissibility_unchanged_by_universal_constraint
    constraint huniversal state).symm

/-- Distinct constraint families can induce the same admissibility
classification. Consequently, classification data alone need not identify
the constraints that generated it. -/
theorem constraint_family_not_recoverable_from_classification
    (constraint : architecture.State → Prop)
    (huniversal : ∀ state, constraint state)
    (hnew : constraint ∉ architecture.constraints) :
    ∃ alternative : Set (architecture.State → Prop),
      alternative ≠ architecture.constraints ∧
      ∀ state, (∀ added ∈ alternative, added state) ↔
        architecture.admissible state := by
  refine ⟨insert constraint architecture.constraints, ?_, ?_⟩
  · intro hequal
    have hmem : constraint ∈ insert constraint architecture.constraints :=
      Set.mem_insert constraint architecture.constraints
    rw [hequal] at hmem
    exact hnew hmem
  · intro state
    exact architecture.admissibility_unchanged_by_universal_constraint
      constraint huniversal state

end ConstraintArchitecture

end ICG
