import SigmaR.Valuation.StandingValuation
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity

/-!
###############################################################################
# Structural Debt Monotonicity Under Autonomy Loss
###############################################################################

Structural debt is defined as:

  Debt(s,i) =
    max(0, σ₀(i) - σv(s,i))

Standing loss therefore corresponds
to accumulated repair obligation.

We show that
standing loss increases structural debt.

The clamp at zero is part of the definition: debt measures the shortfall below
the agent's baseline, and a shortfall that is already zero cannot grow.  The
strict conclusion therefore carries the hypothesis that the shortfall is
positive at the earlier state — exactly the case in which the clamp does not
absorb the change.  `σv` is integer-valued, so the comparison is core-Lean
arithmetic (`omega`) rather than a Mathlib order on the reals.
-/

namespace SigmaR

variable (σ₀ : Agent → Int)

/--
Structural debt definition:
the shortfall of standing below the agent's baseline.
-/
noncomputable def Debt (s : State) (i : Agent) : Int :=
  max 0 (σ₀ i - σv i s)

/--
Debt equals the standing shortfall whenever that shortfall is positive.
-/
theorem debt_eq_gap_of_pos
  (s : State) (i : Agent)
  (h : 0 < σ₀ i - σv i s) :
  Debt σ₀ s i = σ₀ i - σv i s :=
by
  unfold Debt
  rw [Int.max_def]
  split <;> omega

/--
Debt is monotone under σ decrease:
a structural loss of standing strictly increases the shortfall below baseline.
-/
theorem debt_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σv i (apply F s) < σv i s →
    0 < σ₀ i - σv i s →
    Debt σ₀ (apply F s) i > Debt σ₀ s i :=
by
  intro F s i _hAdm hLoss hPos
  have hGap : Debt σ₀ s i = σ₀ i - σv i s := debt_eq_gap_of_pos σ₀ s i hPos
  have hNew : Debt σ₀ (apply F s) i ≥ σ₀ i - σv i (apply F s) := by
    unfold Debt
    exact Int.le_max_right 0 _
  rw [hGap]
  omega

end SigmaR
