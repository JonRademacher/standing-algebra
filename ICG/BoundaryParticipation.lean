module

public import Mathlib.Basic.Real.Basic

@[expose] public section

namespace ICG

/-- Local boundary dominance: membership in the first boundary within the
declared region entails membership in the second, so the second adds no
additional local classification. -/
def BoundaryDominates {State : Type*}
    (region first second : Set State) : Prop :=
  ∀ state, state ∈ region → state ∈ first → state ∈ second

/-- A local analysis retains states governed by both boundaries. -/
def JointBoundaryAnalysis {State : Type*}
    (region first second : Set State) : Set State :=
  region ∩ first ∩ second

/-- Removing a locally dominated boundary preserves the analyzed states. -/
theorem boundary_reduction
    {State : Type*} {region first second : Set State}
    (dominance : BoundaryDominates region first second) :
    JointBoundaryAnalysis region first second = region ∩ first := by
  ext state
  constructor
  · intro h
    exact ⟨h.1.1, h.1.2⟩
  · rintro ⟨hregion, hfirst⟩
    exact ⟨⟨hregion, hfirst⟩,
      dominance state hregion hfirst⟩

/-- Explicit numerical observables for the source's pressure, susceptibility,
representation, and legitimacy claims. The monotonicity obligations are
fields, since the source does not define scales that would derive them. -/
structure BoundaryParticipationArchitecture
    (Participant Region : Type*) where
  compatibilityPressure : Participant → Region → ℝ
  transitionSusceptibility : Participant → Region → ℝ
  representation : Participant → Region → ℝ
  boundaryLegitimacy : Participant → Region → ℝ
  susceptibility_monotone_in_pressure :
    ∀ participant₁ participant₂ region,
      compatibilityPressure participant₁ region ≤
        compatibilityPressure participant₂ region →
          transitionSusceptibility participant₁ region ≤
            transitionSusceptibility participant₂ region
  legitimacy_monotone_in_representation :
    ∀ participant₁ participant₂ region,
      representation participant₁ region ≤ representation participant₂ region →
        boundaryLegitimacy participant₁ region ≤
          boundaryLegitimacy participant₂ region

namespace BoundaryParticipationArchitecture

variable {Participant Region : Type*}
variable (architecture : BoundaryParticipationArchitecture Participant Region)

/-- Absolute pressure difference between participants in a common region. -/
def pressureAsymmetry (first second : Participant) (region : Region) : ℝ :=
  |architecture.compatibilityPressure first region -
    architecture.compatibilityPressure second region|

theorem pressure_asymmetry_nonnegative
    (first second : Participant) (region : Region) :
    0 ≤ architecture.pressureAsymmetry first second region :=
  abs_nonneg _

theorem pressure_asymmetry_symmetric
    (first second : Participant) (region : Region) :
    architecture.pressureAsymmetry first second region =
      architecture.pressureAsymmetry second first region := by
  simp [pressureAsymmetry, abs_sub_comm]

/-- Under the declared calibration, greater pressure entails no less
transition susceptibility. -/
theorem pressure_order_implies_susceptibility_order
    (first second : Participant) (region : Region)
    (pressure_order :
      architecture.compatibilityPressure first region ≤
        architecture.compatibilityPressure second region) :
    architecture.transitionSusceptibility first region ≤
      architecture.transitionSusceptibility second region := by
  exact architecture.susceptibility_monotone_in_pressure
    first second region pressure_order

/-- The declared representation scale makes legitimacy monotone under
increased representational participation. -/
theorem representation_order_implies_legitimacy_order
    (first second : Participant) (region : Region)
    (representation_order :
      architecture.representation first region ≤
        architecture.representation second region) :
    architecture.boundaryLegitimacy first region ≤
      architecture.boundaryLegitimacy second region :=
  architecture.legitimacy_monotone_in_representation
    first second region representation_order

end BoundaryParticipationArchitecture

end ICG
