module

public import ICG.ClosureCertificate

@[expose] public section

namespace ICG

universe u v

/-- A regime-relative sufficient witness for excluding a candidate. -/
structure WitnessedAdmissibility (Candidate : Type u) (Regime : Type v) where
  Witness : Type*
  sufficient : Regime → Candidate → Witness → Prop

namespace WitnessedAdmissibility

variable {Candidate : Type u} {Regime : Type v}
  (admissibility : WitnessedAdmissibility Candidate Regime)

/-- The admissibility filtration retains candidates for which no sufficient
elimination witness exists in the declared regime. -/
def filter (regime : Regime) (candidates : Set Candidate) : Set Candidate :=
  {candidate | candidate ∈ candidates ∧
    ¬ ∃ witness, admissibility.sufficient regime candidate witness}

/-- The candidates removed by a filtration step. -/
def eliminated (regime : Regime) (candidates : Set Candidate) : Set Candidate :=
  candidates \ admissibility.filter regime candidates

theorem contractive (regime : Regime) (candidates : Set Candidate) :
    admissibility.filter regime candidates ⊆ candidates := by
  intro candidate h
  exact h.1

theorem no_candidate_generation (regime : Regime) (candidates : Set Candidate)
    {candidate : Candidate}
    (h : candidate ∈ admissibility.filter regime candidates) :
    candidate ∈ candidates :=
  h.1

theorem survives_iff_no_sufficient_witness (regime : Regime)
    (candidates : Set Candidate) (candidate : Candidate) :
    candidate ∈ admissibility.filter regime candidates ↔
      candidate ∈ candidates ∧
        ¬ ∃ witness, admissibility.sufficient regime candidate witness :=
  Iff.rfl

theorem elimination_iff_sufficient_witness (regime : Regime)
    (candidates : Set Candidate) (candidate : Candidate) :
    candidate ∈ admissibility.eliminated regime candidates ↔
      candidate ∈ candidates ∧
        ∃ witness, admissibility.sufficient regime candidate witness := by
  simp [eliminated, filter]

theorem eliminated_has_sufficient_witness (regime : Regime)
    (candidates : Set Candidate) {candidate : Candidate}
    (h : candidate ∈ admissibility.eliminated regime candidates) :
    ∃ witness, admissibility.sufficient regime candidate witness :=
  (admissibility.elimination_iff_sufficient_witness regime candidates candidate).mp h |>.2

theorem no_witness_survives (regime : Regime) (candidates : Set Candidate)
    {candidate : Candidate} (hcandidate : candidate ∈ candidates)
    (hnoWitness : ¬ ∃ witness, admissibility.sufficient regime candidate witness) :
    candidate ∈ admissibility.filter regime candidates :=
  ⟨hcandidate, hnoWitness⟩

theorem fixed_regime_filter_idempotent (regime : Regime)
    (candidates : Set Candidate) :
    admissibility.filter regime (admissibility.filter regime candidates) =
      admissibility.filter regime candidates := by
  ext candidate
  simp [filter]

theorem elimination_complement (regime : Regime) (candidates : Set Candidate) :
    admissibility.eliminated regime candidates =
      {candidate | candidate ∈ candidates ∧
        ∃ witness, admissibility.sufficient regime candidate witness} := by
  ext candidate
  exact admissibility.elimination_iff_sufficient_witness regime candidates candidate

end WitnessedAdmissibility

/-- Contractive operators can be composed without ever generating candidates. -/
def composeFiltrations {Candidate : Type u}
    (first second : Set Candidate → Set Candidate) : Set Candidate → Set Candidate :=
  fun candidates => second (first candidates)

theorem composeFiltrations_contractive {Candidate : Type u}
    (first second : Set Candidate → Set Candidate)
    (hfirst : ∀ candidates, first candidates ⊆ candidates)
    (hsecond : ∀ candidates, second candidates ⊆ candidates) :
    ∀ candidates, composeFiltrations first second candidates ⊆ candidates := by
  intro candidates candidate h
  exact hfirst candidates (hsecond (first candidates) h)

/-- Any finite succession of contractive operators remains contractive. -/
def applyFiltrations {Candidate : Type u}
    (operators : List (Set Candidate → Set Candidate)) :
    Set Candidate → Set Candidate
  | candidates => operators.foldl (fun current operator => operator current) candidates

theorem applyFiltrations_contractive {Candidate : Type u}
    (operators : List (Set Candidate → Set Candidate))
    (hcontractive : ∀ operator ∈ operators, ∀ candidates,
      operator candidates ⊆ candidates) :
    ∀ candidates, applyFiltrations operators candidates ⊆ candidates := by
  intro candidates
  induction operators generalizing candidates with
  | nil =>
      exact Set.Subset.rfl
  | cons operator operators ih =>
      change applyFiltrations operators (operator candidates) ⊆ candidates
      have htailContractive : ∀ next ∈ operators, ∀ landscape,
          next landscape ⊆ landscape := by
        intro next hnext landscape
        exact hcontractive next (by simp [hnext]) landscape
      have htail := ih htailContractive (operator candidates)
      exact htail.trans (hcontractive operator (by simp) candidates)

/-- Under pointwise admissibility, filtering is monotone in the input landscape. -/
theorem pointwise_filter_monotone {Candidate : Type u} {Regime : Type v}
    (admissibility : WitnessedAdmissibility Candidate Regime)
    (regime : Regime) {smaller larger : Set Candidate}
    (hsubset : smaller ⊆ larger) :
    admissibility.filter regime smaller ⊆ admissibility.filter regime larger := by
  intro candidate h
  exact ⟨hsubset h.1, h.2⟩

/-- Relational witnesses may depend on the whole candidate landscape. -/
structure RelationalFiltration (Candidate : Type u) (Regime : Type v) where
  Witness : Type*
  sufficient : Regime → Set Candidate → Candidate → Witness → Prop

namespace RelationalFiltration

variable {Candidate : Type u} {Regime : Type v}
  (filtration : RelationalFiltration Candidate Regime)

def filter (regime : Regime) (candidates : Set Candidate) : Set Candidate :=
  {candidate | candidate ∈ candidates ∧
    ¬ ∃ witness, filtration.sufficient regime candidates candidate witness}

theorem contractive (regime : Regime) (candidates : Set Candidate) :
    filtration.filter regime candidates ⊆ candidates := by
  intro candidate h
  exact h.1

/-- Relational monotonicity is not automatic: the hypothesis explicitly rules
out newly created exclusion witnesses when the landscape is enlarged. -/
theorem monotone_of_no_new_witness
    (regime : Regime) {smaller larger : Set Candidate}
    (hsubset : smaller ⊆ larger)
    (hnoNewWitness : ∀ candidate, candidate ∈ smaller →
      (¬ ∃ witness, filtration.sufficient regime smaller candidate witness) →
      ¬ ∃ witness, filtration.sufficient regime larger candidate witness) :
    filtration.filter regime smaller ⊆ filtration.filter regime larger := by
  intro candidate h
  exact ⟨hsubset h.1, hnoNewWitness candidate h.1 h.2⟩

end RelationalFiltration

def iterateFilter {Candidate : Type u} (filter : Set Candidate → Set Candidate)
    (initial : Set Candidate) : Nat → Set Candidate
  | 0 => initial
  | n + 1 => filter (iterateFilter filter initial n)

/-- A fixed point is stable under every further application of the same operator. -/
theorem fixedPoint_iterates {Candidate : Type u}
    (filter : Set Candidate → Set Candidate) (initial : Set Candidate)
    (hfixed : filter initial = initial) (n : Nat) :
    iterateFilter filter initial n = initial := by
  induction n with
  | zero =>
      rfl
  | succ n ih =>
      simp [iterateFilter, ih, hfixed]

/-- A selected realization is an external operation whose result is constrained
to lie in the survivor landscape. -/
structure ExternalSelector {Candidate : Type u} (survivors : Set Candidate) where
  choose : Option Candidate
  selected_survives : ∀ ⦃candidate⦄, choose = some candidate → candidate ∈ survivors

def selectZero : ExternalSelector ({0, 1} : Set Nat) where
  choose := some 0
  selected_survives := by
    intro candidate h
    simp at h
    subst candidate
    simp

def selectOne : ExternalSelector ({0, 1} : Set Nat) where
  choose := some 1
  selected_survives := by
    intro candidate h
    simp at h
    subst candidate
    simp

/-- The same plural survivor set permits distinct external selections; filtering
alone does not determine a preferred realization. -/
theorem same_survivors_allow_distinct_selections :
    selectZero.choose ≠ selectOne.choose ∧
      selectZero.choose = some 0 ∧ selectOne.choose = some 1 := by
  exact ⟨by decide, rfl, rfl⟩

theorem selected_candidate_remains_a_survivor
    {Candidate : Type u} {survivors : Set Candidate}
    (selector : ExternalSelector survivors) {candidate : Candidate}
    (hselected : selector.choose = some candidate) :
    candidate ∈ survivors :=
  selector.selected_survives hselected

/-- Even a contractive filter need not be idempotent: eliminating one candidate
can expose a witness against another candidate on the next application. -/
def cascadingFilter : Set Nat → Set Nat :=
  fun candidates =>
    {candidate | candidate ∈ candidates ∧
      ¬ ((candidate = 0 ∧ 1 ∈ candidates) ∨
        (candidate = 1 ∧ 0 ∉ candidates))}

theorem cascadingFilter_contractive (candidates : Set Nat) :
    cascadingFilter candidates ⊆ candidates := by
  intro candidate h
  exact h.1

def cascadingCandidates : Set Nat := {0, 1}

theorem cascading_first_stage :
    cascadingFilter cascadingCandidates = {1} := by
  ext candidate
  change (candidate ∈ cascadingCandidates ∧
      ¬ ((candidate = 0 ∧ 1 ∈ cascadingCandidates) ∨
        (candidate = 1 ∧ 0 ∉ cascadingCandidates))) ↔ candidate = 1
  constructor
  · intro h
    rcases h with ⟨hcandidates, hnotEliminated⟩
    simp [cascadingCandidates] at hcandidates
    rcases hcandidates with hzero | hone
    · subst candidate
      simp [cascadingCandidates] at hnotEliminated
    · exact hone
  · intro h
    subst candidate
    constructor
    · simp [cascadingCandidates]
    · simp [cascadingCandidates]

theorem cascading_second_stage :
    cascadingFilter (cascadingFilter cascadingCandidates) = ∅ := by
  rw [cascading_first_stage]
  ext candidate
  change (candidate ∈ ({1} : Set Nat) ∧
      ¬ ((candidate = 0 ∧ 1 ∈ ({1} : Set Nat)) ∨
        (candidate = 1 ∧ 0 ∉ ({1} : Set Nat)))) ↔ False
  constructor
  · rintro ⟨hcandidate, hnotEliminated⟩
    have hone : candidate = 1 := Set.mem_singleton_iff.mp hcandidate
    subst candidate
    apply hnotEliminated
    exact Or.inr ⟨rfl, by simp⟩
  · intro hfalse
    exact hfalse.elim

theorem contractive_does_not_imply_idempotent :
    cascadingFilter (cascadingFilter cascadingCandidates) ≠
      cascadingFilter cascadingCandidates := by
  rw [cascading_second_stage, cascading_first_stage]
  intro h
  have hone : (1 : Nat) ∈ ({1} : Set Nat) := by simp
  rw [← h] at hone
  simp at hone

/-- Two different witness records may produce the same endpoint; endpoint
equality alone therefore does not identify filtration provenance. -/
inductive ExampleWitness
  | leftReason
  | rightReason
  deriving DecidableEq

def provenanceWitness : Bool → Nat → ExampleWitness → Prop
  | true, 0, .leftReason => True
  | false, 0, .rightReason => True
  | _, _, _ => False

def provenanceFilter (regime : Bool) (candidates : Set Nat) : Set Nat :=
  {candidate | candidate ∈ candidates ∧
    ¬ ∃ witness, provenanceWitness regime candidate witness}

def provenanceCandidates : Set Nat := {0, 1}

theorem provenance_true_witness_exists (candidate : Nat) :
    (∃ witness, provenanceWitness true candidate witness) ↔ candidate = 0 := by
  constructor
  · rintro ⟨witness, hwitness⟩
    cases candidate with
    | zero => rfl
    | succ candidate =>
        cases witness <;> simp [provenanceWitness] at hwitness
  · intro h
    subst candidate
    exact ⟨ExampleWitness.leftReason, trivial⟩

theorem provenance_false_witness_exists (candidate : Nat) :
    (∃ witness, provenanceWitness false candidate witness) ↔ candidate = 0 := by
  constructor
  · rintro ⟨witness, hwitness⟩
    cases candidate with
    | zero => rfl
    | succ candidate =>
        cases witness <;> simp [provenanceWitness] at hwitness
  · intro h
    subst candidate
    exact ⟨ExampleWitness.rightReason, trivial⟩

theorem provenance_true_endpoint :
    provenanceFilter true provenanceCandidates = {1} := by
  ext candidate
  change (candidate ∈ provenanceCandidates ∧
      ¬ ∃ witness, provenanceWitness true candidate witness) ↔ candidate = 1
  rw [provenance_true_witness_exists]
  change ((candidate = 0 ∨ candidate = 1) ∧ ¬ candidate = 0) ↔ candidate = 1
  constructor
  · rintro ⟨hcandidates, hnotZero⟩
    rcases hcandidates with hzero | hone
    · exact (hnotZero hzero).elim
    · exact hone
  · intro hone
    subst candidate
    exact ⟨Or.inr rfl, by decide⟩

theorem provenance_false_endpoint :
    provenanceFilter false provenanceCandidates = {1} := by
  ext candidate
  change (candidate ∈ provenanceCandidates ∧
      ¬ ∃ witness, provenanceWitness false candidate witness) ↔ candidate = 1
  rw [provenance_false_witness_exists]
  change ((candidate = 0 ∨ candidate = 1) ∧ ¬ candidate = 0) ↔ candidate = 1
  constructor
  · rintro ⟨hcandidates, hnotZero⟩
    rcases hcandidates with hzero | hone
    · exact (hnotZero hzero).elim
    · exact hone
  · intro hone
    subst candidate
    exact ⟨Or.inr rfl, by decide⟩

theorem provenance_same_endpoint :
    provenanceFilter true provenanceCandidates =
      provenanceFilter false provenanceCandidates := by
  rw [provenance_true_endpoint, provenance_false_endpoint]

theorem provenance_reasons_differ :
    provenanceWitness true 0 ExampleWitness.leftReason ∧
      provenanceWitness false 0 ExampleWitness.rightReason ∧
      ExampleWitness.leftReason ≠ ExampleWitness.rightReason := by
  exact ⟨trivial, trivial, by decide⟩

end ICG
