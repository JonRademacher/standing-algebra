module

public import ICG.ConstraintClosure

@[expose] public section

namespace ICG

universe u v

/-- A homomorphism of interaction systems transports seeds and derived constraints. -/
structure InteractionHom {Source : Type u} {Target : Type v}
    (sourceRules : InteractionSystem Source) (targetRules : InteractionSystem Target) where
  map : Source → Target
  map_interacts : ∀ {a b c}, sourceRules.interacts a b c →
    targetRules.interacts (map a) (map b) (map c)

namespace InteractionHom

variable {Source : Type u} {Target : Type v}
  {sourceRules : InteractionSystem Source} {targetRules : InteractionSystem Target}

/-- Derivability is preserved under an interaction-system homomorphism. -/
theorem derives_map (hom : InteractionHom sourceRules targetRules)
    {seeds : Set Source} {x : Source}
    (h : Derives sourceRules seeds x) :
    Derives targetRules (hom.map '' seeds) (hom.map x) := by
  induction h with
  | @seed x hseed =>
      exact Derives.seed ⟨x, hseed, rfl⟩
  | interact _ _ hrel ihLeft ihRight =>
      exact Derives.interact ihLeft ihRight (hom.map_interacts hrel)

theorem closure_map (hom : InteractionHom sourceRules targetRules)
    {seeds : Set Source} {x : Source}
    (h : x ∈ closure sourceRules seeds) :
    hom.map x ∈ closure targetRules (hom.map '' seeds) :=
  hom.derives_map h

/-- Reindexing and interaction-preserving transformations induce maps of closures. -/
theorem closure_image_subset (hom : InteractionHom sourceRules targetRules)
    (seeds : Set Source) :
    hom.map '' closure sourceRules seeds ⊆
      closure targetRules (hom.map '' seeds) := by
  rintro y ⟨x, hx, rfl⟩
  exact hom.closure_map hx

end InteractionHom

end ICG
