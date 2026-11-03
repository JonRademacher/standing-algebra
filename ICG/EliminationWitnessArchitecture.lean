module

public import ICG.FiltrationOperators

@[expose] public section

namespace ICG

universe u v w z

/-- A provenance-bearing record of an alleged candidate exclusion. -/
structure EliminationWitnessRecord
    (Candidate : Type u) (Scope : Type v) (Origin : Type w)
    (Condition : Type z) where
  candidate : Candidate
  scope : Scope
  origin : Origin
  failedCondition : Condition
  evidenceSupportsFailure : Prop
  conditionRequiredForAdmissibility : Prop
  evidenceCurrentlyValid : Prop

/-- Witness sufficiency keeps evidentiary support, condition necessity,
applicability, and current validity as separate obligations. -/
structure EliminationWitnessArchitecture
    (Candidate : Type u) (Scope : Type v) (Origin : Type w)
    (Condition : Type z) where
  Witness : Type*
  witnessCandidate : Witness → Candidate
  witnessScope : Witness → Scope
  witnessOrigin : Witness → Origin
  witnessCondition : Witness → Condition
  supportsFailure : Witness → Prop
  conditionRequired : Witness → Prop
  appliesToScope : Witness → Scope → Prop
  currentlyValid : Witness → Prop

namespace EliminationWitnessArchitecture

variable {Candidate : Type u} {Scope : Type v} {Origin : Type w}
  {Condition : Type z}
  (architecture :
    EliminationWitnessArchitecture Candidate Scope Origin Condition)

/-- A sufficient witness must establish a required failure, apply to the
requested scope, and remain valid under the current evidence. -/
def Sufficient (context : Scope) (witness : architecture.Witness) : Prop :=
  architecture.supportsFailure witness ∧
    architecture.conditionRequired witness ∧
    architecture.appliesToScope witness context ∧
    architecture.currentlyValid witness

/-- Elimination is permitted only when a sufficient witness is available. -/
def filter (context : Scope) (candidates : Set Candidate) : Set Candidate :=
  {candidate | candidate ∈ candidates ∧
    ¬ ∃ witness, architecture.witnessCandidate witness = candidate ∧
      architecture.Sufficient context witness}

def eliminated (context : Scope) (candidates : Set Candidate) : Set Candidate :=
  candidates \ architecture.filter context candidates

theorem contractive (context : Scope) (candidates : Set Candidate) :
    architecture.filter context candidates ⊆ candidates := by
  intro candidate h
  exact h.1

theorem elimination_has_sufficient_witness (context : Scope)
    (candidates : Set Candidate) {candidate : Candidate}
    (h : candidate ∈ architecture.eliminated context candidates) :
    ∃ witness, architecture.witnessCandidate witness = candidate ∧
      architecture.Sufficient context witness := by
  rcases h with ⟨hcandidate, hnotRetained⟩
  by_contra hnone
  apply hnotRetained
  exact ⟨hcandidate, hnone⟩

theorem sufficient_witness_justifies_elimination (context : Scope)
    (candidates : Set Candidate) {candidate : Candidate}
    (hcandidate : candidate ∈ candidates)
    (witness : architecture.Witness)
    (hwitness : architecture.witnessCandidate witness = candidate)
    (hsufficient : architecture.Sufficient context witness) :
    candidate ∈ architecture.eliminated context candidates := by
  refine ⟨hcandidate, ?_⟩
  intro hretained
  exact hretained.2 ⟨witness, hwitness, hsufficient⟩

theorem insufficient_evidence_does_not_eliminate
    (context : Scope) (candidates : Set Candidate) {candidate : Candidate}
    (hcandidate : candidate ∈ candidates)
    (hnoSufficientWitness : ¬ ∃ witness,
      architecture.witnessCandidate witness = candidate ∧
        architecture.Sufficient context witness) :
    candidate ∈ architecture.filter context candidates :=
  ⟨hcandidate, hnoSufficientWitness⟩

theorem scope_conservation (witness : architecture.Witness)
    (context : Scope) (hnotApplicable :
      ¬ architecture.appliesToScope witness context) :
    ¬ architecture.Sufficient context witness := by
  intro hsufficient
  exact hnotApplicable hsufficient.2.2.1

theorem correction_reopens_candidate (candidate : Candidate)
    (context : Scope) (candidates : Set Candidate)
    (hcandidate : candidate ∈ candidates)
    (hcorrected : ∀ witness, architecture.witnessCandidate witness = candidate →
      ¬ architecture.Sufficient context witness) :
    candidate ∈ architecture.filter context candidates := by
  apply architecture.insufficient_evidence_does_not_eliminate context candidates hcandidate
  rintro ⟨witness, hwitness, hsufficient⟩
  exact hcorrected witness hwitness hsufficient

theorem surviving_witness_keeps_candidate_excluded
    (context : Scope) (candidates : Set Candidate) {candidate : Candidate}
    (hcandidate : candidate ∈ candidates)
    (witness : architecture.Witness)
    (hwitness : architecture.witnessCandidate witness = candidate)
    (hsufficient : architecture.Sufficient context witness) :
    candidate ∉ architecture.filter context candidates := by
  intro hretained
  exact hretained.2 ⟨witness, hwitness, hsufficient⟩

theorem eliminated_set_iff_witness
    (context : Scope) (candidates : Set Candidate) (candidate : Candidate) :
    candidate ∈ architecture.eliminated context candidates ↔
      candidate ∈ candidates ∧
        ∃ witness, architecture.witnessCandidate witness = candidate ∧
          architecture.Sufficient context witness := by
  constructor
  · intro h
    exact ⟨h.1, architecture.elimination_has_sufficient_witness context candidates h⟩
  · rintro ⟨hcandidate, witness, hwitness, hsufficient⟩
    exact architecture.sufficient_witness_justifies_elimination
      context candidates hcandidate witness hwitness hsufficient

/-- The eliminated set is exactly the part of the active candidate landscape
with a sufficient applicable witness; the remainder is the survivor set. -/
theorem elimination_ledger_reconstructs_filter
    (context : Scope) (candidates : Set Candidate) :
    architecture.eliminated context candidates =
      {candidate | candidate ∈ candidates ∧
        ∃ witness, architecture.witnessCandidate witness = candidate ∧
          architecture.Sufficient context witness} := by
  ext candidate
  exact architecture.eliminated_set_iff_witness context candidates candidate

end EliminationWitnessArchitecture

end ICG
