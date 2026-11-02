module

public import Mathlib.Geometry.Euclidean.Angle.Unoriented.Basic
public import ICG.EnvelopeGeometry

@[expose] public section

namespace ICG

open scoped RealInnerProductSpace

universe u

/-- Directed structural separation. Symmetry is deliberately not assumed. -/
structure DirectedSeparation (Structure : Type u) where
  distance : Structure → Structure → ℝ
  nonnegative : ∀ x y, 0 ≤ distance x y
  self_zero : ∀ x, distance x x = 0
  triangle : ∀ x y z, distance x z ≤ distance x y + distance y z

namespace DirectedSeparation

variable {Structure : Type u} (d : DirectedSeparation Structure)

/-- Reciprocal separation, or phase, forgets the direction of travel. -/
def phase (x y : Structure) : ℝ :=
  d.distance x y + d.distance y x

theorem phase_nonnegative (x y : Structure) : 0 ≤ d.phase x y :=
  add_nonneg (d.nonnegative x y) (d.nonnegative y x)

theorem phase_symmetric (x y : Structure) : d.phase x y = d.phase y x := by
  simp [phase, add_comm]

theorem phase_self (x : Structure) : d.phase x x = 0 := by
  simp [phase, d.self_zero]

/-- A bounded phase coordinate, with values strictly below one. -/
noncomputable def normalizedPhase (x y : Structure) : ℝ :=
  d.phase x y / (1 + d.phase x y)

theorem normalizedPhase_nonnegative (x y : Structure) :
    0 ≤ d.normalizedPhase x y := by
  apply div_nonneg (d.phase_nonnegative x y)
  linarith [d.phase_nonnegative x y]

theorem normalizedPhase_lt_one (x y : Structure) :
    d.normalizedPhase x y < 1 := by
  rw [normalizedPhase, div_lt_one (by linarith [d.phase_nonnegative x y])]
  linarith [d.phase_nonnegative x y]

theorem normalizedPhase_symmetric (x y : Structure) :
    d.normalizedPhase x y = d.normalizedPhase y x := by
  simp [normalizedPhase, phase_symmetric]

theorem normalizedPhase_eq_zero_iff (x y : Structure) :
    d.normalizedPhase x y = 0 ↔ d.phase x y = 0 := by
  rw [normalizedPhase, div_eq_zero_iff]
  constructor
  · rintro (h | h)
    · exact h
    · linarith [d.phase_nonnegative x y]
  · intro h
    exact Or.inl h

/-- The distance and normalized phase determine one another. -/
theorem phase_recovered_from_normalized (x y : Structure) :
    d.phase x y =
      d.normalizedPhase x y / (1 - d.normalizedPhase x y) := by
  unfold normalizedPhase
  have hden : 1 + d.phase x y ≠ 0 := by
    linarith [d.phase_nonnegative x y]
  field_simp
  ring

end DirectedSeparation

namespace Envelope

variable {Generator : Type*} [Fintype Generator]

/-- Canonical angle between finite real envelope vectors. -/
noncomputable def angle (x y : Envelope Generator) : ℝ :=
  InnerProductGeometry.angle x y

theorem angle_symmetric (x y : Envelope Generator) :
    angle x y = angle y x := by
  exact InnerProductGeometry.angle_comm x y

theorem angle_nonnegative (x y : Envelope Generator) : 0 ≤ angle x y :=
  InnerProductGeometry.angle_nonneg x y

theorem angle_le_pi (x y : Envelope Generator) : angle x y ≤ Real.pi :=
  InnerProductGeometry.angle_le_pi x y

/-- Cosine compatibility is the normalized real inner product. -/
theorem cosine_compatibility (x y : Envelope Generator) :
    Real.cos (angle x y) = ⟪x, y⟫ / (‖x‖ * ‖y‖) :=
  InnerProductGeometry.cos_angle x y

theorem sine_nonnegative (x y : Envelope Generator) :
    0 ≤ Real.sin (angle x y) :=
  InnerProductGeometry.sin_angle_nonneg x y

end Envelope

end ICG
