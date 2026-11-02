module

public import ICG.ConstraintClosure

@[expose] public section

namespace ICG

universe u

variable {Constraint : Type u}

/-- A derivation tree retains the finite ancestry of a constraint in interaction closure. -/
inductive DerivationTree (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) : Constraint → Type u
  | seed {c} : c ∈ seeds → DerivationTree rules seeds c
  | interact {a b c} :
      DerivationTree rules seeds a →
      DerivationTree rules seeds b →
      rules.interacts a b c →
      DerivationTree rules seeds c

namespace DerivationTree

/-- The constraints occurring anywhere in a derivation tree, with the root first. -/
def nodes {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) : List Constraint :=
  match tree with
  | .seed _ => [c]
  | .interact left right _ => c :: (left.nodes ++ right.nodes)

/-- The primitive constraints at the leaves of a derivation tree. -/
def leaves {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) : List Constraint :=
  match tree with
  | .seed _ => [c]
  | .interact left right _ => left.leaves ++ right.leaves

/-- The generation depth of this particular derivation. -/
def depth {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) : Nat :=
  match tree with
  | .seed _ => 0
  | .interact left right _ => max left.depth right.depth + 1

/-- The number of interaction nodes in this derivation. -/
def interactionCount {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) : Nat :=
  match tree with
  | .seed _ => 0
  | .interact left right _ => left.interactionCount + right.interactionCount + 1

/-- Forgetting a derivation tree recovers the inductive closure judgment. -/
theorem toDerives {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) :
    Derives rules seeds c := by
  induction tree with
  | seed h =>
      exact Derives.seed h
  | interact left right h ihLeft ihRight =>
      exact Derives.interact ihLeft ihRight h

/-- Every finite derivation judgment has a derivation tree. -/
theorem exists_tree_of_derives {rules : InteractionSystem Constraint}
    {seeds : Set Constraint} {c : Constraint}
    (derivation : Derives rules seeds c) :
    Nonempty (DerivationTree rules seeds c) := by
  induction derivation with
  | seed h =>
      exact ⟨.seed h⟩
  | interact ha hb hab ihLeft ihRight =>
      rcases ihLeft with ⟨left⟩
      rcases ihRight with ⟨right⟩
      exact ⟨.interact left right hab⟩

/-- Choose a concrete ancestry tree for a derivable constraint. -/
noncomputable def ofDerives {rules : InteractionSystem Constraint}
    {seeds : Set Constraint} {c : Constraint}
    (derivation : Derives rules seeds c) : DerivationTree rules seeds c :=
  Classical.choice (exists_tree_of_derives derivation)

theorem root_mem_nodes {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c : Constraint} (tree : DerivationTree rules seeds c) :
    c ∈ tree.nodes := by
  cases tree <;> simp [nodes]

theorem leaves_mem_seeds {rules : InteractionSystem Constraint} {seeds : Set Constraint}
    {c x : Constraint} (tree : DerivationTree rules seeds c)
    (hx : x ∈ tree.leaves) : x ∈ seeds := by
  induction tree with
  | seed h =>
      simp [leaves] at hx
      subst x
      exact h
  | interact left right _ ihLeft ihRight =>
      simp only [leaves, List.mem_append] at hx
      rcases hx with hx | hx
      · exact ihLeft hx
      · exact ihRight hx

/-- If every leaf of a tree is in a family, its root is derivable from that family. -/
theorem toDerives_of_leaves_mem {rules : InteractionSystem Constraint}
    {seeds family : Set Constraint} {c : Constraint}
    (tree : DerivationTree rules seeds c)
    (hleaves : ∀ x ∈ tree.leaves, x ∈ family) :
    Derives rules family c := by
  induction tree with
  | seed h =>
      simp [leaves] at hleaves
      exact Derives.seed hleaves
  | interact left right hab ihLeft ihRight =>
      exact Derives.interact
        (ihLeft (by
          intro x hx
          exact hleaves x (by simp [leaves, hx])))
        (ihRight (by
          intro x hx
          exact hleaves x (by simp [leaves, hx])))
        hab

/-- A derivation from a family has a leaf outside any family from which its root
cannot itself be derived. -/
theorem exists_leaf_outside_of_not_derivable {rules : InteractionSystem Constraint}
    {seeds family : Set Constraint} {c : Constraint}
    (tree : DerivationTree rules seeds c)
    (hnot : ¬ Derives rules family c) :
    ∃ x ∈ tree.leaves, x ∉ family := by
  by_contra h
  apply hnot
  apply tree.toDerives_of_leaves_mem
  intro x hx
  by_contra hxFamily
  exact h ⟨x, hx, hxFamily⟩

/-- An obstruction that is derivable from combined seeds but from neither subsystem
has ancestry in both subsystems. This records contribution, not a claim that one
particular pair of primitive leaves interacts directly. -/
theorem both_subsystems_contribute {rules : InteractionSystem Constraint}
    {leftSeeds rightSeeds : Set Constraint} {c : Constraint}
    (tree : DerivationTree rules (leftSeeds ∪ rightSeeds) c)
    (hnotLeft : ¬ Derives rules leftSeeds c)
    (hnotRight : ¬ Derives rules rightSeeds c) :
    (∃ x ∈ tree.leaves, x ∈ leftSeeds) ∧
      (∃ x ∈ tree.leaves, x ∈ rightSeeds) := by
  obtain ⟨x, hx, hxNotRight⟩ :=
    exists_leaf_outside_of_not_derivable tree hnotRight
  obtain ⟨y, hy, hyNotLeft⟩ :=
    exists_leaf_outside_of_not_derivable tree hnotLeft
  have hxUnion := leaves_mem_seeds tree hx
  have hyUnion := leaves_mem_seeds tree hy
  rcases (Set.mem_union _ _ _).mp hxUnion with hxLeft | hxRight
  · rcases (Set.mem_union _ _ _).mp hyUnion with hyLeft | hyRight
    · exact False.elim (hyNotLeft hyLeft)
    · exact ⟨⟨x, hx, hxLeft⟩, ⟨y, hy, hyRight⟩⟩
  · exact False.elim (hxNotRight hxRight)

end DerivationTree

/-- Emergence means global derivability without derivability from either subsystem
in isolation. -/
def IsEmergent {rules : InteractionSystem Constraint}
    (leftSeeds rightSeeds : Set Constraint) (c : Constraint) : Prop :=
  Derives rules (leftSeeds ∪ rightSeeds) c ∧
    ¬ Derives rules leftSeeds c ∧
    ¬ Derives rules rightSeeds c

/-- Every emergent consequence has a derivation whose primitive support reaches both
subsystems. -/
theorem emergent_has_mixed_ancestry {rules : InteractionSystem Constraint}
    {leftSeeds rightSeeds : Set Constraint} {c : Constraint}
    (h : IsEmergent (rules := rules) leftSeeds rightSeeds c) :
    ∃ tree : DerivationTree rules (leftSeeds ∪ rightSeeds) c,
      (∃ x ∈ tree.leaves, x ∈ leftSeeds) ∧
        (∃ x ∈ tree.leaves, x ∈ rightSeeds) := by
  refine ⟨DerivationTree.ofDerives h.1, ?_⟩
  exact DerivationTree.both_subsystems_contribute
    (DerivationTree.ofDerives h.1) h.2.1 h.2.2

/-- The complete derivation geometry retained for a designated obstruction. -/
structure ObstructionGeometry (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (obstruction : Constraint) where
  derivation : DerivationTree rules seeds obstruction

namespace ObstructionGeometry

variable {rules : InteractionSystem Constraint} {seeds : Set Constraint}
  {obstruction : Constraint}

def depth (geometry : ObstructionGeometry rules seeds obstruction) : Nat :=
  geometry.derivation.depth

def interactionCount (geometry : ObstructionGeometry rules seeds obstruction) : Nat :=
  geometry.derivation.interactionCount

def ancestry (geometry : ObstructionGeometry rules seeds obstruction) : List Constraint :=
  geometry.derivation.nodes

def primitiveSupport (geometry : ObstructionGeometry rules seeds obstruction) :
    List Constraint :=
  geometry.derivation.leaves

theorem obstruction_mem_ancestry
    (geometry : ObstructionGeometry rules seeds obstruction) :
    obstruction ∈ geometry.ancestry :=
  geometry.derivation.root_mem_nodes

theorem primitiveSupport_mem_seeds
    (geometry : ObstructionGeometry rules seeds obstruction) {x : Constraint}
    (hx : x ∈ geometry.primitiveSupport) : x ∈ seeds :=
  geometry.derivation.leaves_mem_seeds hx

end ObstructionGeometry

end ICG
