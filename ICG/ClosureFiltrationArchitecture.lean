module

public import ICG.ConstraintSemantics

@[expose] public section

namespace ICG

universe u

/-- The states retained by applying declared admissibility conditions to a
represented candidate landscape. -/
def survivorLandscape {State : Type u}
    (candidates : Set State) (admissible : State → Prop) : Set State :=
  {state | state ∈ candidates ∧ admissible state}

/-- A candidate removed by the filter, together with its failed admissibility
condition as an elimination witness. -/
def EliminationWitness {State : Type u}
    (candidates : Set State) (admissible : State → Prop) (state : State) : Prop :=
  state ∈ candidates ∧ ¬ admissible state

theorem survivorLandscape_subset {State : Type u}
    (candidates : Set State) (admissible : State → Prop) :
    survivorLandscape candidates admissible ⊆ candidates := by
  intro state h
  exact h.1

theorem survivorLandscape_admissible {State : Type u}
    (candidates : Set State) (admissible : State → Prop)
    {state : State} (h : state ∈ survivorLandscape candidates admissible) :
    admissible state :=
  h.2

theorem eliminated_has_witness {State : Type u}
    (candidates : Set State) (admissible : State → Prop) {state : State}
    (hCandidate : state ∈ candidates)
    (hEliminated : state ∉ survivorLandscape candidates admissible) :
    EliminationWitness candidates admissible state := by
  refine ⟨hCandidate, ?_⟩
  intro hAdmissible
  exact hEliminated ⟨hCandidate, hAdmissible⟩

theorem survivorLandscape_idempotent {State : Type u}
    (candidates : Set State) (admissible : State → Prop) :
    survivorLandscape (survivorLandscape candidates admissible) admissible =
      survivorLandscape candidates admissible := by
  ext state
  simp [survivorLandscape]

/-- The three cardinality-neutral closure outcomes: no survivors, one survivor,
or at least two distinct survivors. -/
inductive SurvivorShape {State : Type u} (survivors : Set State) : Prop
  | none : survivors = ∅ → SurvivorShape survivors
  | unique : (∃ state, survivors = {state}) → SurvivorShape survivors
  | plural : (∃ first ∈ survivors, ∃ second ∈ survivors,
      first ≠ second) → SurvivorShape survivors

theorem survivorShape_trichotomy {State : Type u} (survivors : Set State) :
    SurvivorShape survivors := by
  classical
  by_cases hEmpty : survivors = ∅
  · exact .none hEmpty
  ·
    obtain ⟨first, hfirst⟩ : survivors.Nonempty :=
      Set.nonempty_iff_ne_empty.mpr hEmpty
    by_cases hUnique : ∀ second ∈ survivors, second = first
    · refine SurvivorShape.unique ⟨first, ?_⟩
      ext second
      change second ∈ survivors ↔ second = first
      constructor
      · intro h
        exact hUnique second h
      · intro h
        rw [h]
        exact hfirst
    · push Not at hUnique
      obtain ⟨second, hsecond, hne⟩ := hUnique
      exact .plural ⟨first, hfirst, second, hsecond, Ne.symm hne⟩

/-- A plural survivor landscape does not determine a unique survivor. -/
theorem plural_survivors_not_unique {State : Type u}
    (survivors : Set State) (hplural : ∃ first ∈ survivors, ∃ second ∈ survivors,
      first ≠ second) :
    ¬ ∃ state, survivors = {state} := by
  rintro ⟨state, hsingleton⟩
  rcases hplural with ⟨first, hfirst, second, hsecond, hne⟩
  rw [hsingleton] at hfirst hsecond
  change first = state at hfirst
  change second = state at hsecond
  exact hne (hfirst.trans hsecond.symm)

/-- A unique survivor is characterized by the landscape itself, without adding
a ranking or selection operation. -/
theorem unique_survivor_is_singleton {State : Type u}
    (survivors : Set State) (state : State)
    (hunique : ∀ other ∈ survivors, other = state)
    (hstate : state ∈ survivors) :
    survivors = {state} := by
  ext other
  change other ∈ survivors ↔ other = state
  constructor
  · intro h
    exact hunique other h
  · intro h
    rw [h]
    exact hstate

/-- A candidate set together with its admissibility filter and exact survivor
landscape. No preferred member is selected. -/
structure ClosureFiltration (State : Type u) where
  candidates : Set State
  admissible : State → Prop
  survivors : Set State
  survivors_eq : survivors = survivorLandscape candidates admissible

namespace ClosureFiltration

variable {State : Type u} (filtration : ClosureFiltration State)

theorem survivors_subset_candidates : filtration.survivors ⊆ filtration.candidates := by
  rw [filtration.survivors_eq]
  exact survivorLandscape_subset _ _

theorem survivors_are_admissible {state : State}
    (h : state ∈ filtration.survivors) : filtration.admissible state := by
  rw [filtration.survivors_eq] at h
  exact survivorLandscape_admissible _ _ h

theorem survivors_have_shape : SurvivorShape filtration.survivors :=
  survivorShape_trichotomy filtration.survivors

end ClosureFiltration

/-- An updated admissibility predicate can reopen a previously removed candidate
when its new evidence establishes admissibility. -/
theorem candidate_reenters_after_admissibility_update {State : Type u}
    (candidates : Set State) (oldAdmissible newAdmissible : State → Prop)
    {state : State} (hCandidate : state ∈ candidates)
    (hOldExcluded : ¬ oldAdmissible state) (hNewAdmissible : newAdmissible state) :
    state ∉ survivorLandscape candidates oldAdmissible ∧
      state ∈ survivorLandscape candidates newAdmissible := by
  constructor
  · intro h
    exact hOldExcluded h.2
  · exact ⟨hCandidate, hNewAdmissible⟩

end ICG
