module

public import ICG.EnvelopeGeometry
public import ICG.ObstructionGeometry

@[expose] public section

namespace ICG

namespace Envelope

variable {Generator : Type*} [Fintype Generator] [DecidableEq Generator]

/-- Coordinates carrying nonzero structural weight in a finite envelope. -/
noncomputable def support (x : Envelope Generator) : Finset Generator :=
  Finset.univ.filter fun i => x i ≠ 0

omit [DecidableEq Generator] in
theorem mem_support_iff (x : Envelope Generator) (i : Generator) :
    i ∈ support x ↔ x i ≠ 0 := by
  simp [support]

omit [DecidableEq Generator] in
@[simp]
theorem support_zero : support (0 : Envelope Generator) = ∅ := by
  ext i
  simp [support]

theorem support_add_subset (x y : Envelope Generator) :
    support (x + y) ⊆ support x ∪ support y := by
  intro i hi
  simp only [support, Finset.mem_filter, Finset.mem_univ, true_and] at hi
  simp only [support, Finset.mem_union, Finset.mem_filter, Finset.mem_univ, true_and]
  by_contra h
  push Not at h
  apply hi
  simp [h.1, h.2]

omit [DecidableEq Generator] in
theorem support_neg (x : Envelope Generator) :
    support (-x) = support x := by
  ext i
  simp [mem_support_iff]

theorem support_sub_subset (x y : Envelope Generator) :
    support (x - y) ⊆ support x ∪ support y := by
  simpa only [sub_eq_add_neg, support_neg] using support_add_subset x (-y)

/-- The finite support cardinality is a structural sparsity measure. -/
noncomputable def supportSize (x : Envelope Generator) : Nat :=
  (support x).card

omit [DecidableEq Generator] in
theorem supportSize_nonnegative (x : Envelope Generator) : 0 ≤ supportSize x :=
  Nat.zero_le _

end Envelope

namespace DerivationTree

variable {Constraint : Type*} [DecidableEq Constraint]
  {rules : InteractionSystem Constraint} {seeds : Set Constraint}
  {c : Constraint}

/-- Primitive ancestry, with duplicate leaves identified. -/
def primitiveSupport (tree : DerivationTree rules seeds c) : Finset Constraint :=
  tree.leaves.toFinset

theorem primitiveSupport_subset_seeds (tree : DerivationTree rules seeds c) :
    ↑tree.primitiveSupport ⊆ seeds := by
  intro x hx
  exact tree.leaves_mem_seeds (List.mem_toFinset.mp hx)

end DerivationTree

end ICG
