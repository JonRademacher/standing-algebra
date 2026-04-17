import SigmaR.Core.StandingValuation
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity

/-!
###############################################################################
# Structural Debt Monotonicity Under Autonomy Loss
###############################################################################

Structural debt is defined as:

  D(s,i) =
    max(0, σ_baseline(i) - σ(s,i))

Standing loss therefore corresponds
to accumulated repair obligation.

We show that
structurally admissible operations
which reduce standing
must increase structural debt.
-/

namespace SigmaR

variables
  (σ₀ : Agent → ℝ)

/--
Structural debt definition.
-/
def Debt (s : State) (i : Agent) : ℝ :=
  max 0 (σ₀ i - σ s i)

/--
Debt is monotone under σ decrease.
-/
theorem debt_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σ (apply F s) i < σ s i →
    Debt σ₀ (apply F s) i >
    Debt σ₀ s i :=
begin
  intros F s i hAdm hLoss,

  unfold Debt,

  have hσ :
    σ₀ i - σ (apply F s) i >
    σ₀ i - σ s i,
  { linarith },

  apply lt_of_lt_of_le hσ,
  apply le_max_left
end

end SigmaR
