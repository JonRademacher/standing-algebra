module

public import ICG.EliminationWitnessArchitecture

@[expose] public section

namespace ICG

universe u v

/-- A closure mechanism transforms an initial candidate landscape under a
declared admissibility regime. -/
structure ClosureMechanism (Candidate : Type u) (Regime : Type v) where
  run : Regime → Set Candidate → Set Candidate

namespace ClosureMechanism

variable {Candidate : Type u} {Regime : Type v}
  (admissibility : WitnessedAdmissibility Candidate Regime)

/-- A mechanism is faithful when it returns exactly the candidates left by
the declared witness-based admissibility filtration. -/
def IsFaithful (mechanism : ClosureMechanism Candidate Regime) : Prop :=
  ∀ regime initial,
    mechanism.run regime initial = admissibility.filter regime initial

theorem faithful_output_is_filter
    (mechanism : ClosureMechanism Candidate Regime)
    (hfaithful : mechanism.IsFaithful admissibility)
    (regime : Regime) (initial : Set Candidate) :
    mechanism.run regime initial = admissibility.filter regime initial :=
  hfaithful regime initial

end ClosureMechanism

/-- A post-closure selector is unwarranted when it removes a survivor from a
stable admissibility landscape without any applicable sufficient witness. -/
structure UnwarrantedSelector {Candidate : Type u} {Regime : Type v}
    (admissibility : WitnessedAdmissibility Candidate Regime) where
  regime : Regime
  closed : Set Candidate
  result : Set Candidate
  closed_is_fixed :
    admissibility.filter regime closed = closed
  result_subset_closed : result ⊆ closed
  removes_unwitnessed_survivor :
    ∃ candidate, candidate ∈ closed ∧ candidate ∉ result ∧
      ¬ ∃ witness, admissibility.sufficient regime candidate witness

namespace UnwarrantedSelector

variable {Candidate : Type u} {Regime : Type v}
  {admissibility : WitnessedAdmissibility Candidate Regime}
  (selector : UnwarrantedSelector admissibility)

/-- An unwarranted selector strictly contracts a landscape already closed
under the declared admissibility filtration. -/
theorem strict_contraction : selector.result ⊂ selector.closed := by
  refine ⟨selector.result_subset_closed, ?_⟩
  intro hsubset
  obtain ⟨candidate, hclosed, hremoved, _⟩ :=
    selector.removes_unwitnessed_survivor
  exact hremoved (hsubset hclosed)

/-- The selector's result cannot itself be the admissibility closure of its
closed input: that would silently identify unsupported selection with closure. -/
theorem result_is_not_admissibility_closure :
    selector.result ≠
      admissibility.filter selector.regime selector.closed := by
  intro heq
  obtain ⟨candidate, hclosed, hremoved, hnoWitness⟩ :=
    selector.removes_unwitnessed_survivor
  have hsurvives :
      candidate ∈ admissibility.filter selector.regime selector.closed :=
    admissibility.no_witness_survives selector.regime selector.closed
      hclosed hnoWitness
  rw [← heq] at hsurvives
  exact hremoved hsurvives

end UnwarrantedSelector

/-- Structural preservation compares candidate landscapes as sets; it does
not rank the individual candidates within them. -/
def preservesAtLeastAsManySurvivors {Candidate : Type u}
    (preferred alternative : Set Candidate) : Prop :=
  alternative ⊆ preferred

theorem closed_landscape_preserves_selector_removed_survivor
    {Candidate : Type u} {Regime : Type v}
    {admissibility : WitnessedAdmissibility Candidate Regime}
    (selector : UnwarrantedSelector admissibility) :
    preservesAtLeastAsManySurvivors selector.closed selector.result ∧
      ¬ selector.result = selector.closed :=
  ⟨selector.result_subset_closed, by
    intro heq
    apply selector.strict_contraction.2
    simp [heq]⟩

/-- A finite example: a witnessed exclusion may legitimately reduce
cardinality, so structural fidelity is not cardinality maximization. -/
def excludeZero : WitnessedAdmissibility Nat Unit where
  Witness := Unit
  sufficient := fun _ candidate _ => candidate = 0

theorem witnessed_exclusion_reduces_cardinality :
    (excludeZero.filter () ({0, 1} : Set Nat)) = ({1} : Set Nat) ∧
      ({1} : Finset Nat).card < ({0, 1} : Finset Nat).card := by
  constructor
  · ext candidate
    rcases candidate with _ | _ | candidate <;>
      simp [WitnessedAdmissibility.filter, excludeZero]
  · decide

/-- Preference between closure mechanisms is typed separately from any
relation that might rank surviving candidates. -/
def MechanismPreference {Candidate : Type u} {Regime : Type v}
    (mechanismRelation :
      ClosureMechanism Candidate Regime →
        ClosureMechanism Candidate Regime → Prop)
    (left right : ClosureMechanism Candidate Regime) : Prop :=
  mechanismRelation left right

end ICG
