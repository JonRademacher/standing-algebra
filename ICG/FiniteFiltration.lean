module

public import ICG.ClosureFiltrationArchitecture
public import Mathlib.Data.Finset.Card

@[expose] public section

namespace ICG

universe u

/-- A fixed admissibility procedure that only removes candidates and records a
witness for every removal. -/
structure AccountableFilter (Candidate : Type u) (Witness : Candidate → Prop) where
  retain : Finset Candidate → Finset Candidate
  retain_subset : ∀ landscape, retain landscape ⊆ landscape
  removal_witness : ∀ landscape candidate,
    candidate ∈ landscape → candidate ∉ retain landscape → Witness candidate

namespace AccountableFilter

variable {Candidate : Type u} {Witness : Candidate → Prop}
  (filter : AccountableFilter Candidate Witness)

/-- Iterating the same fixed filter generates successive finite survivor sets. -/
def stage (initial : Finset Candidate) : Nat → Finset Candidate
  | 0 => initial
  | n + 1 => filter.retain (stage initial n)

/-- Candidates removed by the transition from stage `n` to stage `n + 1`. -/
noncomputable def eliminatedAt (filter : AccountableFilter Candidate Witness)
    (initial : Finset Candidate) (n : Nat) : Finset Candidate := by
  classical
  exact (filter.stage initial n).filter
    (fun candidate => candidate ∉ filter.stage initial (n + 1))

theorem stage_succ_subset (initial : Finset Candidate) (n : Nat) :
    filter.stage initial (n + 1) ⊆ filter.stage initial n :=
  filter.retain_subset _

theorem eliminatedAt_iff (initial : Finset Candidate) (n : Nat)
    (candidate : Candidate) :
    candidate ∈ filter.eliminatedAt initial n ↔
      candidate ∈ filter.stage initial n ∧
        candidate ∉ filter.stage initial (n + 1) := by
  simp [eliminatedAt]

theorem stage_subset_initial (initial : Finset Candidate) (n : Nat) :
    filter.stage initial n ⊆ initial := by
  induction n with
  | zero =>
      exact Finset.Subset.rfl
  | succ n ih =>
      exact (filter.stage_succ_subset initial n).trans ih

theorem eliminatedAt_has_witness (initial : Finset Candidate) (n : Nat)
    {candidate : Candidate}
    (h : candidate ∈ filter.eliminatedAt initial n) :
    Witness candidate :=
  filter.removal_witness _ candidate
    (filter.eliminatedAt_iff initial n candidate |>.mp h |>.1)
    (filter.eliminatedAt_iff initial n candidate |>.mp h |>.2)

theorem removed_candidates_have_witness (initial : Finset Candidate) (n : Nat)
    {candidate : Candidate}
    (hcandidate : candidate ∈ filter.stage initial n)
    (hremoved : candidate ∉ filter.stage initial (n + 1)) :
    Witness candidate :=
  filter.removal_witness _ candidate hcandidate hremoved

theorem strict_reduction_has_witness (initial : Finset Candidate) (n : Nat)
    (hstrict : filter.stage initial n ≠ filter.stage initial (n + 1)) :
    ∃ candidate, candidate ∈ filter.eliminatedAt initial n := by
  have hnotSubset :
      ¬ filter.stage initial n ⊆ filter.stage initial (n + 1) := by
    intro hsubset
    exact hstrict (Finset.Subset.antisymm hsubset
      (filter.stage_succ_subset initial n))
  obtain ⟨candidate, hcandidate, hremoved⟩ :=
    Finset.not_subset.mp hnotSubset
  exact ⟨candidate, (filter.eliminatedAt_iff initial n candidate).mpr
    ⟨hcandidate, hremoved⟩⟩

theorem strict_reduction_has_sufficient_accounting
    (initial : Finset Candidate) (n : Nat)
    (hstrict : filter.stage initial n ≠ filter.stage initial (n + 1)) :
    ∃ candidate, candidate ∈ filter.eliminatedAt initial n ∧
      Witness candidate := by
  obtain ⟨candidate, hremoved⟩ :=
    filter.strict_reduction_has_witness initial n hstrict
  exact ⟨candidate, hremoved, filter.eliminatedAt_has_witness initial n hremoved⟩

theorem strict_reduction_lowers_cardinality (initial : Finset Candidate) (n : Nat)
    (hstrict : filter.stage initial n ≠ filter.stage initial (n + 1)) :
    (filter.stage initial (n + 1)).card < (filter.stage initial n).card := by
  have hproper : filter.stage initial (n + 1) ⊂ filter.stage initial n :=
    Finset.ssubset_iff_subset_ne.mpr
      ⟨filter.stage_succ_subset initial n, Ne.symm hstrict⟩
  exact Finset.card_lt_card hproper

theorem no_witness_means_retained (initial : Finset Candidate) (n : Nat)
    {candidate : Candidate}
    (hcandidate : candidate ∈ filter.stage initial n)
    (hnoWitness : ¬ Witness candidate) :
    candidate ∈ filter.stage initial (n + 1) := by
  by_contra hnext
  exact hnoWitness (filter.removed_candidates_have_witness initial n hcandidate hnext)

private theorem card_stage_decreases (initial : Finset Candidate) :
    ∀ n, (∀ i < n, filter.stage initial i ≠ filter.stage initial (i + 1)) →
      (filter.stage initial n).card + n ≤ initial.card := by
  intro n
  induction n with
  | zero =>
      intro _
      simp [stage]
  | succ n ih =>
      intro hstrict
      have hprevious := ih (fun i hi => hstrict i (Nat.lt_succ_of_lt hi))
      have hnotEq := hstrict n (Nat.lt_succ_self n)
      have hproper :
          filter.stage initial (n + 1) ⊂ filter.stage initial n :=
        Finset.ssubset_iff_subset_ne.mpr
          ⟨filter.stage_succ_subset initial n, Ne.symm hnotEq⟩
      have hcard : (filter.stage initial (n + 1)).card + 1 <
          (filter.stage initial n).card + 1 :=
        Nat.add_lt_add_right (Finset.card_lt_card hproper) 1
      have hstep :
          (filter.stage initial (n + 1)).card + (n + 1) ≤
            (filter.stage initial n).card + n := by
        omega
      exact le_trans hstep hprevious

/-- On a finite candidate landscape, a fixed contractive filter stabilizes after
at most the initial number of candidates. Witness accountability is retained at
every transition; stabilization does not assert a unique survivor. -/
theorem exists_stable_stage (initial : Finset Candidate) :
    ∃ n ≤ initial.card, filter.stage initial n = filter.stage initial (n + 1) := by
  classical
  by_contra hnone
  push Not at hnone
  have hstrict : ∀ i < initial.card + 1,
      filter.stage initial i ≠ filter.stage initial (i + 1) := by
    intro i hi heq
    apply hnone i
    · omega
    · exact heq
  have hbound := filter.card_stage_decreases initial (initial.card + 1) hstrict
  omega

theorem stable_stage_is_fixedPoint (initial : Finset Candidate) (n : Nat)
    (hstable : filter.stage initial n = filter.stage initial (n + 1)) :
    filter.retain (filter.stage initial n) = filter.stage initial n := by
  simpa [stage] using hstable.symm

/-- Subsequent reapplication of the same filter leaves a stabilized landscape
unchanged. -/
theorem stable_stage_iterate (initial : Finset Candidate) (n : Nat)
    (hstable : filter.stage initial n = filter.stage initial (n + 1))
    (m : Nat) :
    filter.stage initial (n + m) = filter.stage initial n := by
  induction m with
  | zero =>
      simp
  | succ m ih =>
      rw [show n + (m + 1) = (n + m) + 1 by omega]
      change filter.retain (filter.stage initial (n + m)) =
        filter.stage initial n
      rw [ih]
      rw [filter.stable_stage_is_fixedPoint initial n hstable]

end AccountableFilter

/-- A concrete plural fixed point: the identity filter preserves two candidates. -/
def stablePluralKeepAll : AccountableFilter Nat (fun _ => False) where
  retain landscape := landscape
  retain_subset _ := Finset.Subset.rfl
  removal_witness landscape candidate hCandidate hremoved := by
    exact hremoved hCandidate

def stablePluralCandidates : Finset Nat := {0, 1}

theorem stablePluralKeepAll_stable :
    stablePluralKeepAll.stage stablePluralCandidates 0 =
      stablePluralKeepAll.stage stablePluralCandidates 1 := by
  simp [AccountableFilter.stage, stablePluralKeepAll]

theorem stablePluralKeepAll_plural :
    (∃ first ∈ stablePluralKeepAll.stage stablePluralCandidates 0,
      ∃ second ∈ stablePluralKeepAll.stage stablePluralCandidates 0, first ≠ second) := by
  refine ⟨0, ?_, 1, ?_, by decide⟩
  · simp [stablePluralCandidates, AccountableFilter.stage]
  · simp [stablePluralCandidates, AccountableFilter.stage]

end ICG
