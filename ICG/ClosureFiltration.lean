module

public import ICG.ConstraintClosure

@[expose] public section

namespace ICG

universe u

variable {Constraint : Type u}

/-- One generation step: retain existing constraints and add all pairwise interactions. -/
def interactionStep (rules : InteractionSystem Constraint)
    (constraints : Set Constraint) : Set Constraint :=
  constraints ∪ {c | ∃ a ∈ constraints, ∃ b ∈ constraints, rules.interacts a b c}

/-- The constraints available after a fixed finite number of interaction rounds. -/
def closureStage (rules : InteractionSystem Constraint) (seeds : Set Constraint) :
    Nat → Set Constraint
  | 0 => seeds
  | n + 1 => interactionStep rules (closureStage rules seeds n)

theorem subset_interactionStep (rules : InteractionSystem Constraint)
    (constraints : Set Constraint) :
    constraints ⊆ interactionStep rules constraints :=
  Set.subset_union_left

theorem interactionStep_mono (rules : InteractionSystem Constraint)
    {constraints₁ constraints₂ : Set Constraint} (h : constraints₁ ⊆ constraints₂) :
    interactionStep rules constraints₁ ⊆ interactionStep rules constraints₂ := by
  intro c hc
  rcases (Set.mem_union _ _ _).mp hc with hc | hc
  · exact Set.mem_union_left _ (h hc)
  · rcases hc with ⟨a, ha, b, hb, hab⟩
    exact Set.mem_union_right _ ⟨a, h ha, b, h hb, hab⟩

theorem closureStage_succ (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (n : Nat) :
    closureStage rules seeds n ⊆ closureStage rules seeds (n + 1) := by
  induction n with
  | zero =>
      exact subset_interactionStep rules seeds
  | succ n ih =>
      exact interactionStep_mono rules ih

theorem closureStage_mono (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) {n m : Nat} (h : n ≤ m) :
    closureStage rules seeds n ⊆ closureStage rules seeds m := by
  induction h with
  | refl =>
      exact Set.Subset.rfl
  | @step m h ih =>
      exact Set.Subset.trans ih (closureStage_succ rules seeds m)

/-- Every finitely derivable constraint appears at some finite closure stage. -/
theorem exists_closureStage_of_derives (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) {c : Constraint} (h : Derives rules seeds c) :
    ∃ n, c ∈ closureStage rules seeds n := by
  induction h with
  | seed hc =>
      exact ⟨0, hc⟩
  | @interact a b c ha hb hab ihA ihB =>
      obtain ⟨n, hn⟩ := ihA
      obtain ⟨m, hm⟩ := ihB
      refine ⟨max n m + 1, ?_⟩
      change c ∈ interactionStep rules (closureStage rules seeds (max n m))
      apply Set.mem_union_right
      exact ⟨a, closureStage_mono rules seeds (Nat.le_max_left n m) hn,
        b, closureStage_mono rules seeds (Nat.le_max_right n m) hm, hab⟩

/-- Every member of a finite closure stage has a finite interaction derivation. -/
theorem derives_of_mem_closureStage (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) :
    ∀ n {c : Constraint}, c ∈ closureStage rules seeds n → Derives rules seeds c
  | 0, c, hc => Derives.seed hc
  | n + 1, c, hc => by
      change c ∈ interactionStep rules (closureStage rules seeds n) at hc
      rcases (Set.mem_union _ _ _).mp hc with hc | hc
      · exact derives_of_mem_closureStage rules seeds n hc
      · rcases hc with ⟨a, ha, b, hb, hab⟩
        exact Derives.interact
          (derives_of_mem_closureStage rules seeds n ha)
          (derives_of_mem_closureStage rules seeds n hb) hab

/-- Finite interaction closure is exactly the union of its finite generation stages. -/
theorem mem_closure_iff_exists_closureStage (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) {c : Constraint} :
    c ∈ closure rules seeds ↔ ∃ n, c ∈ closureStage rules seeds n := by
  rw [closure]
  constructor
  · exact exists_closureStage_of_derives rules seeds
  · rintro ⟨n, hn⟩
    exact derives_of_mem_closureStage rules seeds n hn

end ICG
