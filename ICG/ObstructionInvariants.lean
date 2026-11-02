module

public import ICG.BoundaryInteraction
public import ICG.ObstructionGeometry
public import Mathlib.Data.Finset.Card
public import Mathlib.Data.Nat.Find
public import Mathlib.Basic.Real.Basic

@[expose] public section

open Classical

namespace ICG

universe u

variable {Constraint : Type u}

/-- The earliest finite interaction stage at which a constraint appears. -/
noncomputable def closureDepth (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds) : Nat := by
  classical
  exact Nat.find ((mem_closure_iff_exists_closureStage rules seeds).mp h)

theorem closureDepth_spec (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds) :
    c ∈ closureStage rules seeds (closureDepth rules seeds c h) := by
  classical
  exact Nat.find_spec ((mem_closure_iff_exists_closureStage rules seeds).mp h)

theorem closureDepth_minimal (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds)
    {n : Nat} (hn : c ∈ closureStage rules seeds n) :
    closureDepth rules seeds c h ≤ n := by
  classical
  exact Nat.find_min' ((mem_closure_iff_exists_closureStage rules seeds).mp h) hn

/-- Every consequence has at least one finite derivation tree and hence a tree depth. -/
theorem exists_derivationDepth (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds) :
    ∃ depth, ∃ tree : DerivationTree rules seeds c, tree.depth = depth := by
  classical
  obtain ⟨n, hn⟩ := (mem_closure_iff_exists_closureStage rules seeds).mp h
  let tree := DerivationTree.ofDerives (derives_of_mem_closureStage rules seeds n hn)
  exact ⟨tree.depth, tree, rfl⟩

/-- The least possible maximum branch depth among derivation trees for a consequence. -/
noncomputable def minimalDerivationDepth (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds) : Nat :=
  Nat.find (exists_derivationDepth rules seeds c h)

theorem minimalDerivationDepth_spec (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds) :
    ∃ tree : DerivationTree rules seeds c, tree.depth = minimalDerivationDepth rules seeds c h := by
  classical
  change ∃ tree : DerivationTree rules seeds c,
    tree.depth = Nat.find (exists_derivationDepth rules seeds c h)
  rcases Nat.find_spec (exists_derivationDepth rules seeds c h) with ⟨tree, htree⟩
  exact ⟨tree, htree⟩

theorem minimalDerivationDepth_minimal (rules : InteractionSystem Constraint)
    (seeds : Set Constraint) (c : Constraint) (h : c ∈ closure rules seeds)
    {tree : DerivationTree rules seeds c} :
    minimalDerivationDepth rules seeds c h ≤ tree.depth :=
  Nat.find_min' (exists_derivationDepth rules seeds c h)
      ⟨tree, rfl⟩

namespace DerivationTree

variable [DecidableEq Constraint] {rules : InteractionSystem Constraint} {seeds : Set Constraint}
  {c : Constraint}

/-- A node on a derivation path is a descendant of the root in the tree's ancestry. -/
def nodeSet (tree : DerivationTree rules seeds c) : Finset Constraint :=
  tree.nodes.toFinset

theorem root_mem_nodeSet (tree : DerivationTree rules seeds c) :
    c ∈ tree.nodeSet := by
  exact List.mem_toFinset.mpr tree.root_mem_nodes

end DerivationTree

namespace ObstructionGeometry

variable [DecidableEq Constraint] {rules : InteractionSystem Constraint} {seeds : Set Constraint}
  {obstruction : Constraint}

/-- The finite nodes in a particular derivation tree that lie in the closure of
the first-order cross-system boundary. This is a derivation-local realization of
the treatise's boundary-participation measure. -/
noncomputable def boundaryNodes (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) : Finset Constraint := by
  classical
  exact geometry.derivation.nodeSet.filter
    (fun c => c ∈ closure rules (boundaryInteractions rules left right))

/-- Fraction of distinct nodes in a derivation tree that are boundary-generated. -/
noncomputable def boundaryDensity
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) : ℝ :=
  (geometry.boundaryNodes left right).card /
    (geometry.derivation.nodeSet.card : ℝ)

theorem boundaryNodes_subset
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) :
    geometry.boundaryNodes left right ⊆ geometry.derivation.nodeSet :=
  Finset.filter_subset _ _

theorem nodeSet_nonempty
    (geometry : ObstructionGeometry rules seeds obstruction) :
    geometry.derivation.nodeSet.Nonempty :=
  ⟨obstruction, geometry.derivation.root_mem_nodeSet⟩

theorem boundaryDensity_nonnegative
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) :
    0 ≤ geometry.boundaryDensity left right := by
  exact div_nonneg (Nat.cast_nonneg _) (Nat.cast_nonneg _)

theorem boundaryDensity_le_one
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) :
    geometry.boundaryDensity left right ≤ 1 := by
  have hden : 0 < (geometry.derivation.nodeSet.card : ℝ) := by
    exact_mod_cast Finset.card_pos.mpr geometry.nodeSet_nonempty
  apply (div_le_one hden).2
  exact_mod_cast Finset.card_le_card (geometry.boundaryNodes_subset left right)

theorem boundaryDensity_eq_zero_iff
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) :
    geometry.boundaryDensity left right = 0 ↔
      geometry.boundaryNodes left right = ∅ := by
  have hden : (geometry.derivation.nodeSet.card : ℝ) ≠ 0 := by
    exact ne_of_gt (by
      exact_mod_cast Finset.card_pos.mpr geometry.nodeSet_nonempty)
  simp [boundaryDensity, hden]

theorem boundaryDensity_eq_one_iff
    (geometry : ObstructionGeometry rules seeds obstruction)
    (left right : Set Constraint) :
    geometry.boundaryDensity left right = 1 ↔
      geometry.boundaryNodes left right = geometry.derivation.nodeSet := by
  have hden : (geometry.derivation.nodeSet.card : ℝ) ≠ 0 := by
    exact ne_of_gt (by
      exact_mod_cast Finset.card_pos.mpr geometry.nodeSet_nonempty)
  rw [boundaryDensity, div_eq_one_iff_eq hden]
  constructor
  · intro h
    apply Finset.eq_of_subset_of_card_le (geometry.boundaryNodes_subset left right)
    exact_mod_cast h.ge
  · intro h
    exact_mod_cast congrArg Finset.card h

end ObstructionGeometry

end ICG
