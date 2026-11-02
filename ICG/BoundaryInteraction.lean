module

public import ICG.ClosureFiltration

@[expose] public section

namespace ICG

universe u

variable {Constraint : Type u}

/-- Outputs obtained by applying an interaction rule to a left and a right family. -/
def interactionOutputs (rules : InteractionSystem Constraint)
    (left right : Set Constraint) : Set Constraint :=
  {c | ∃ a ∈ left, ∃ b ∈ right, rules.interacts a b c}

/-- Directed cross-system interactions retain the order of the two subsystems. -/
def directedBoundaryInteractions (rules : InteractionSystem Constraint)
    (left right : Set Constraint) : Set Constraint :=
  interactionOutputs rules left right

/-- The full boundary includes cross-system interactions in both directions. -/
def boundaryInteractions (rules : InteractionSystem Constraint)
    (left right : Set Constraint) : Set Constraint :=
  directedBoundaryInteractions rules left right ∪
    directedBoundaryInteractions rules right left

/-- Interactions wholly internal to one constraint family. -/
def internalInteractions (rules : InteractionSystem Constraint)
    (family : Set Constraint) : Set Constraint :=
  interactionOutputs rules family family

/-- Every first-generation interaction from the combined system is either internal
to one subsystem or crosses the boundary in one of its two directions. -/
theorem combinedInteractions_decompose (rules : InteractionSystem Constraint)
    (left right : Set Constraint) :
    interactionOutputs rules (left ∪ right) (left ∪ right) =
      (internalInteractions rules left ∪ internalInteractions rules right) ∪
        boundaryInteractions rules left right := by
  ext c
  constructor
  · intro hc
    change ∃ a ∈ left ∪ right, ∃ b ∈ left ∪ right, rules.interacts a b c at hc
    rcases hc with ⟨a, ha, b, hb, hab⟩
    rcases ha with ha | ha <;> rcases hb with hb | hb
    · apply Set.mem_union_left
      apply Set.mem_union_left
      exact ⟨a, ha, b, hb, hab⟩
    · apply Set.mem_union_right
      apply Set.mem_union_left
      change ∃ a ∈ left, ∃ b ∈ right, rules.interacts a b c
      exact ⟨a, ha, b, hb, hab⟩
    · apply Set.mem_union_right
      apply Set.mem_union_right
      change ∃ a ∈ right, ∃ b ∈ left, rules.interacts a b c
      exact ⟨a, ha, b, hb, hab⟩
    · apply Set.mem_union_left
      apply Set.mem_union_right
      exact ⟨a, ha, b, hb, hab⟩
  · intro hc
    rcases (Set.mem_union _ _ _).mp hc with hInternal | hBoundary
    · rcases (Set.mem_union _ _ _).mp hInternal with hLeft | hRight
      · change ∃ a ∈ left, ∃ b ∈ left, rules.interacts a b c at hLeft
        rcases hLeft with ⟨a, ha, b, hb, hab⟩
        exact ⟨a, Or.inl ha, b, Or.inl hb, hab⟩
      · change ∃ a ∈ right, ∃ b ∈ right, rules.interacts a b c at hRight
        rcases hRight with ⟨a, ha, b, hb, hab⟩
        exact ⟨a, Or.inr ha, b, Or.inr hb, hab⟩
    · rcases (Set.mem_union _ _ _).mp hBoundary with hLeftRight | hRightLeft
      · change ∃ a ∈ left, ∃ b ∈ right, rules.interacts a b c at hLeftRight
        rcases hLeftRight with ⟨a, ha, b, hb, hab⟩
        exact ⟨a, Or.inl ha, b, Or.inr hb, hab⟩
      · change ∃ a ∈ right, ∃ b ∈ left, rules.interacts a b c at hRightLeft
        rcases hRightLeft with ⟨a, ha, b, hb, hab⟩
        exact ⟨a, Or.inr ha, b, Or.inl hb, hab⟩

/-- First-generation mixed interactions belong to the finite closure of the union
of their source subsystems. -/
theorem boundaryInteractions_subset_closure (rules : InteractionSystem Constraint)
    (left right : Set Constraint) :
    boundaryInteractions rules left right ⊆ closure rules (left ∪ right) := by
  intro c hc
  rcases (Set.mem_union _ _ _).mp hc with hc | hc
  · rcases hc with ⟨a, ha, b, hb, hab⟩
    exact Derives.interact
      (Derives.seed (Set.mem_union_left right ha))
      (Derives.seed (Set.mem_union_right left hb))
      hab
  · rcases hc with ⟨a, ha, b, hb, hab⟩
    exact Derives.interact
      (Derives.seed (Set.mem_union_right left ha))
      (Derives.seed (Set.mem_union_left right hb))
      hab

/-- A symmetric interaction rule makes directed cross-system output independent
of which subsystem is named first. -/
theorem directedBoundaryInteractions_eq_swap_of_symmetric
    (rules : InteractionSystem Constraint)
    (hsymmetric : ∀ ⦃a b c⦄, rules.interacts a b c → rules.interacts b a c)
    (left right : Set Constraint) :
    directedBoundaryInteractions rules left right =
      directedBoundaryInteractions rules right left := by
  ext c
  constructor
  · rintro ⟨a, ha, b, hb, hab⟩
    exact ⟨b, hb, a, ha, hsymmetric hab⟩
  · rintro ⟨b, hb, a, ha, hba⟩
    exact ⟨a, ha, b, hb, hsymmetric hba⟩

end ICG
