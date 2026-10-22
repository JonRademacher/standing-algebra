module

public import ICG.EnvelopeGeometry
public import ICG.DirectedPhaseGeometry

@[expose] public section

namespace ICG

open scoped RealInnerProductSpace

universe u

/-- Orthogonal transformations are the identity-preserving motions of envelope space. -/
abbrev OrthogonalMotion (E : Type u) [NormedAddCommGroup E] [InnerProductSpace ℝ E] :=
  E ≃ₗᵢ[ℝ] E

namespace OrthogonalMotion

variable {E : Type u} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

theorem norm_preserved (R : OrthogonalMotion E) (x : E) : ‖R x‖ = ‖x‖ :=
  R.norm_map x

theorem inner_preserved (R : OrthogonalMotion E) (x y : E) :
    ⟪R x, R y⟫ = ⟪x, y⟫ :=
  R.inner_map_map x y

theorem distance_preserved (R : OrthogonalMotion E) (x y : E) :
    dist (R x) (R y) = dist x y := by
  rw [dist_eq_norm, dist_eq_norm, ← map_sub, norm_preserved]

theorem angle_preserved (R : OrthogonalMotion E) (x y : E) :
    InnerProductGeometry.angle (R x) (R y) =
      InnerProductGeometry.angle x y :=
  R.toLinearIsometry.angle_map x y

/-- A motion is admissible for a family when it maps that family onto itself. -/
def PreservesFamily (R : OrthogonalMotion E) (family : Submodule ℝ E) : Prop :=
  ∀ x, x ∈ family ↔ R x ∈ family

theorem projection_equivariant (R : OrthogonalMotion E) (family : Submodule ℝ E)
    [family.HasOrthogonalProjection]
    (hfamily : PreservesFamily R family) (x : E) :
    family.starProjection (R x) = R (family.starProjection x) := by
  apply Submodule.eq_starProjection_of_mem_orthogonal
  · exact hfamily _ |>.mp (Submodule.starProjection_apply_mem family x)
  · apply (Submodule.mem_orthogonal' family _).2
    intro y hy
    have hy' : R.symm y ∈ family := (hfamily (R.symm y)).mpr (by simpa using hy)
    have horth := (Submodule.mem_orthogonal' family _).mp
      (Submodule.sub_starProjection_mem_orthogonal (K := family) x)
      (R.symm y) hy'
    have hinner :
        ⟪R (x - family.starProjection x), y⟫ =
          ⟪x - family.starProjection x, R.symm y⟫ := by
      simpa using R.inner_map_map (x - family.starProjection x) (R.symm y)
    rw [← map_sub]
    exact hinner.trans horth

end OrthogonalMotion

end ICG
