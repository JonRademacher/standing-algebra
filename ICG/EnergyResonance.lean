module

public import ICG.EnvelopeGeometry

@[expose] public section

namespace ICG

namespace Envelope

variable {Generator : Type*} [Fintype Generator]

/-- Amplitude is the magnitude of the structure left outside a chosen family. -/
noncomputable def amplitude {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (family : Submodule ℝ E) [family.HasOrthogonalProjection] (x : E) : ℝ :=
  ‖residual family x‖

/-- Residual energy is the squared magnitude excluded by projection. -/
noncomputable def residualEnergy {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) : ℝ :=
  amplitude family x ^ 2

/-- Represented energy is the squared magnitude retained by projection. -/
noncomputable def representedEnergy {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) : ℝ :=
  ‖projection family x‖ ^ 2

theorem energy_decomposition {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    ‖x‖ ^ 2 = representedEnergy family x + residualEnergy family x := by
  simpa [representedEnergy, residualEnergy, amplitude] using
    projection_pythagorean family x

theorem amplitude_nonnegative {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (family : Submodule ℝ E)
    [family.HasOrthogonalProjection] (x : E) :
    0 ≤ amplitude family x :=
  norm_nonneg _

end Envelope

/-- A nonzero vector is a resonance mode of an operator at a scalar parameter. -/
def ResonanceMode {E : Type*} [AddCommMonoid E] [Module ℝ E]
    (operator : E →ₗ[ℝ] E) (parameter : ℝ) (x : E) : Prop :=
  x ≠ 0 ∧ operator x = parameter • x

/-- The spectrum represented by real resonance modes of a linear operator. -/
def resonanceSpectrum {E : Type*} [AddCommMonoid E] [Module ℝ E]
    (operator : E →ₗ[ℝ] E) : Set ℝ :=
  {parameter | ∃ x, ResonanceMode operator parameter x}

/-- Intertwining transports resonance modes and their parameters. -/
theorem resonanceMode_transport {E : Type*} [AddCommMonoid E] [Module ℝ E]
    (source target : E →ₗ[ℝ] E) (equivalence : E ≃ₗ[ℝ] E)
    (hintertwines : ∀ x, target (equivalence x) = equivalence (source x))
    {parameter : ℝ} {x : E}
    (hmode : ResonanceMode source parameter x) :
    ResonanceMode target parameter (equivalence x) := by
  constructor
  · intro hzero
    apply hmode.1
    exact equivalence.injective (by simpa using hzero)
  · rw [hintertwines, hmode.2, map_smul]

theorem resonanceSpectrum_transport {E : Type*} [AddCommMonoid E] [Module ℝ E]
    (source target : E →ₗ[ℝ] E) (equivalence : E ≃ₗ[ℝ] E)
    (hintertwines : ∀ x, target (equivalence x) = equivalence (source x)) :
    resonanceSpectrum source ⊆ resonanceSpectrum target := by
  intro parameter hparameter
  rcases hparameter with ⟨x, hmode⟩
  exact ⟨equivalence x, resonanceMode_transport source target equivalence
    hintertwines hmode⟩

end ICG
