module

public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.Analysis.InnerProductSpace.Projection.Basic

@[expose] public section

namespace ICG

/-- A finite envelope is a real-valued structural profile indexed by its generators. -/
abbrev Envelope (Generator : Type*) [Fintype Generator] :=
  EuclideanSpace ℝ Generator

namespace Envelope

variable {Generator : Type*} [Fintype Generator]

/-- The structural separation induced by the envelope norm. -/
noncomputable def distance (x y : Envelope Generator) : ℝ := dist x y

theorem distance_nonneg (x y : Envelope Generator) : 0 ≤ distance x y :=
  dist_nonneg

theorem distance_eq_zero_iff (x y : Envelope Generator) :
    distance x y = 0 ↔ x = y :=
  dist_eq_zero

theorem distance_comm (x y : Envelope Generator) : distance x y = distance y x :=
  by simpa [distance] using (dist_comm x y)

/-- The component of an envelope represented inside a closed geometric family. -/
noncomputable def projection {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (family : Submodule ℝ E) [family.HasOrthogonalProjection] (x : E) : E :=
  family.starProjection x

/-- The part of an envelope left outside its projection anchor. -/
noncomputable def residual {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (family : Submodule ℝ E) [family.HasOrthogonalProjection] (x : E) : E :=
  x - projection family x

theorem projection_mem {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (family : Submodule ℝ E) [family.HasOrthogonalProjection] (x : E) :
    projection family x ∈ family := by
  exact Submodule.starProjection_apply_mem family x

theorem residual_mem_orthogonal {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    residual family x ∈ familyᗮ := by
  exact Submodule.sub_starProjection_mem_orthogonal (K := family) x

/-- Every envelope decomposes into a represented anchor and an orthogonal residual. -/
theorem projection_add_residual {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    projection family x + residual family x = x := by
  change projection family x + (x - projection family x) = x
  rw [add_comm (projection family x) (x - projection family x)]
  exact sub_add_cancel x (projection family x)

/-- The projection anchor is the unique family member with orthogonal residual. -/
theorem projection_unique {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x anchor : E)
    (hAnchor : anchor ∈ family) (hResidual : x - anchor ∈ familyᗮ) :
    projection family x = anchor := by
  exact Submodule.eq_starProjection_of_mem_orthogonal
    (K := family) hAnchor hResidual

/-- Orthogonal projection minimizes the residual norm over the target family. -/
theorem residual_norm_minimal {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    ‖residual family x‖ = ⨅ y : family, ‖x - y‖ := by
  simpa [residual, projection] using
    (Submodule.starProjection_minimal (U := family) x)

/-- Squared envelope magnitude splits into represented and residual magnitudes. -/
theorem projection_pythagorean {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    ‖x‖ ^ 2 = ‖projection family x‖ ^ 2 + ‖residual family x‖ ^ 2 := by
  simpa [projection, residual] using
    (Submodule.norm_sq_eq_add_norm_sq_starProjection x family)

/-- Orthogonal projection is stable under perturbations of the source envelope. -/
theorem projection_lipschitz {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] :
    LipschitzWith 1 (projection family) := by
  exact family.lipschitzWith_starProjection

end Envelope

end ICG
