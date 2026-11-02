module

public import ICG.ClosureFiltration

@[expose] public section

namespace ICG

universe u v

/-- A state space equipped with a satisfaction relation for structural constraints. -/
structure ConstraintSystem (State : Type u) (Constraint : Type v) where
  satisfies : Constraint → State → Prop

namespace ConstraintSystem

variable {State : Type u} {Constraint : Type v}
  (system : ConstraintSystem State Constraint)

/-- States satisfying every constraint in a family. -/
def admissible (family : Set Constraint) : Set State :=
  {s | ∀ c ∈ family, system.satisfies c s}

/-- States violating at least one constraint in a family. -/
def violationRegion (family : Set Constraint) : Set State :=
  {s | ∃ c ∈ family, ¬ system.satisfies c s}

theorem admissible_iff_not_mem_violationRegion (family : Set Constraint) (s : State) :
    s ∈ system.admissible family ↔ s ∉ system.violationRegion family := by
  simp [admissible, violationRegion]

theorem admissible_mono {family₁ family₂ : Set Constraint}
    (h : family₁ ⊆ family₂) :
    system.admissible family₂ ⊆ system.admissible family₁ := by
  intro s hs c hc
  exact hs c (h hc)

theorem violationRegion_mono {family₁ family₂ : Set Constraint}
    (h : family₁ ⊆ family₂) :
    system.violationRegion family₁ ⊆ system.violationRegion family₂ := by
  intro s hs
  rcases hs with ⟨c, hc, hviolates⟩
  exact ⟨c, h hc, hviolates⟩

/-- The interaction rules preserve truth at a state when both inputs hold there. -/
def InteractionSound (rules : InteractionSystem Constraint) (s : State) : Prop :=
  ∀ ⦃a b c⦄, system.satisfies a s → system.satisfies b s →
    rules.interacts a b c → system.satisfies c s

theorem closure_satisfied {rules : InteractionSystem Constraint}
    {seeds : Set Constraint} {s : State}
    (hseed : ∀ c ∈ seeds, system.satisfies c s)
    (hsound : system.InteractionSound rules s) :
    ∀ c ∈ closure rules seeds, system.satisfies c s := by
  intro c hc
  induction hc with
  | seed h =>
      exact hseed _ h
  | interact _ _ hab ihA ihB =>
      exact hsound ihA ihB hab

theorem closure_admissible_mono {rules : InteractionSystem Constraint}
    (family : Set Constraint) (s : State)
    (hsound : system.InteractionSound rules s) :
    s ∈ system.admissible family →
      s ∈ system.admissible (closure rules family) := by
  intro hs c hc
  exact system.closure_satisfied hs hsound c hc

/-- States still admissible after the first `n` interaction rounds. -/
def survivors {rules : InteractionSystem Constraint} (seeds : Set Constraint)
    (n : Nat) : Set State :=
  system.admissible (closureStage rules seeds n)

theorem survivors_antitone {rules : InteractionSystem Constraint}
    (seeds : Set Constraint) {n m : Nat} (h : n ≤ m) :
    system.survivors (rules := rules) seeds m ⊆
      system.survivors (rules := rules) seeds n := by
  intro s hs c hc
  exact hs c (closureStage_mono rules seeds h hc)

/-- A constraint first appearing at stage `n + 1` and excluding a previous survivor. -/
structure EliminationWitness {rules : InteractionSystem Constraint}
    (seeds : Set Constraint) (n : Nat) (s : State) where
  constraint : Constraint
  appears : constraint ∈ closureStage rules seeds (n + 1)
  newAtStage : constraint ∉ closureStage rules seeds n
  violated : ¬ system.satisfies constraint s

/-- Any state eliminated by a new closure round has a concrete new violated constraint. -/
theorem exists_eliminationWitness {rules : InteractionSystem Constraint}
    (seeds : Set Constraint) (n : Nat) (s : State)
    (hbefore : s ∈ system.survivors (rules := rules) seeds n)
    (hafter : s ∉ system.survivors (rules := rules) seeds (n + 1)) :
    Nonempty (system.EliminationWitness (rules := rules) seeds n s) := by
  by_contra hnone
  apply hafter
  intro c hc
  by_cases hprevious : c ∈ closureStage rules seeds n
  · exact hbefore c hprevious
  · by_contra hholds
    exact hnone ⟨⟨c, hc, hprevious, hholds⟩⟩

theorem interactionSound_prevents_elimination {rules : InteractionSystem Constraint}
    (seeds : Set Constraint) (s : State)
    (hseed : ∀ c ∈ seeds, system.satisfies c s)
    (hsound : system.InteractionSound rules s) (n : Nat) :
    s ∈ system.survivors (rules := rules) seeds n := by
  induction n with
  | zero =>
      intro c hc
      exact hseed c hc
  | succ n ih =>
      intro c hc
      change c ∈ interactionStep rules (closureStage rules seeds n) at hc
      rcases (Set.mem_union _ _ _).mp hc with hc | hc
      · exact ih c hc
      · rcases hc with ⟨a, ha, b, hb, hab⟩
        exact hsound (ih a ha) (ih b hb) hab

end ConstraintSystem

/-- Constraints produced by interactions that cross a chosen subsystem boundary. -/
def boundaryInteractionOutputs {Constraint : Type v}
    (rules : InteractionSystem Constraint) (left right : Set Constraint) :
    Set Constraint :=
  {c | (∃ a ∈ left, ∃ b ∈ right, rules.interacts a b c) ∨
       (∃ a ∈ right, ∃ b ∈ left, rules.interacts a b c)}

theorem boundaryInteractionOutputs_subset_closure {Constraint : Type v}
    (rules : InteractionSystem Constraint) (left right : Set Constraint) :
    boundaryInteractionOutputs rules left right ⊆ closure rules (left ∪ right) := by
  intro c hc
  rcases hc with ⟨a, ha, b, hb, hab⟩ | ⟨a, ha, b, hb, hab⟩
  · exact Derives.interact
      (Derives.seed (Set.mem_union_left right ha))
      (Derives.seed (Set.mem_union_right left hb)) hab
  · exact Derives.interact
      (Derives.seed (Set.mem_union_right left ha))
      (Derives.seed (Set.mem_union_left right hb)) hab

end ICG
