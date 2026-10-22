import SigmaR.Valuation.StandingValuation
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity

/-!
###############################################################################
# Structural Debt Monotonicity Under Autonomy Loss
###############################################################################

Structural debt is defined as the natural-number shortfall from a
baseline. A standing decrease increases debt when the state is already
below that baseline.

Standing loss therefore corresponds
to accumulated repair obligation.

We show that
structurally admissible operations
which reduce standing
must increase structural debt.
-/

namespace SigmaR

variable
  (σ₀ : Agent → Nat)

/--
Structural debt definition.
-/
noncomputable def Debt (s : State) (i : Agent) : Nat :=
  σ₀ i - σ s

/--
Debt is monotone under σ decrease.
-/
theorem debt_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σ (apply F s) < σ s →
    σ s < σ₀ i →
    Debt σ₀ (apply F s) i >
    Debt σ₀ s i := by
  intro F s i _ hLoss hDebt
  simp only [Debt]
  omega

end SigmaR
