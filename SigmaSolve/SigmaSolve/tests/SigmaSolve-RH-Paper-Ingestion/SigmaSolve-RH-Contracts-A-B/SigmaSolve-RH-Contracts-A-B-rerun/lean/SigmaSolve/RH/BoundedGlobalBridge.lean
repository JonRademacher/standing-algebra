import Mathlib

namespace SigmaSolve.RH
open Complex

/-- Pure logical bridge: a pointwise property holds globally iff it holds in every
positive absolute-height window. -/
theorem global_iff_all_bounded
    (Relevant OnTarget : ℂ → Prop) :
    (∀ ρ, Relevant ρ → OnTarget ρ) ↔
      (∀ T : ℝ, 0 < T → ∀ ρ,
        Relevant ρ → |ρ.im| ≤ T → OnTarget ρ) := by
  constructor
  · intro h T hT ρ hρ hheight
    exact h ρ hρ
  · intro h ρ hρ
    let T : ℝ := |ρ.im| + 1
    have hT : 0 < T := by
      dsimp [T]
      linarith [abs_nonneg ρ.im]
    have hheight : |ρ.im| ≤ T := by
      dsimp [T]
      linarith
    exact h T hT ρ hρ hheight

end SigmaSolve.RH
