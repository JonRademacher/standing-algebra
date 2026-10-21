import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Regimes.StandingAlgebra_DriftRegime

/-!
###############################################################################
# Drift Structural Debt Justification
###############################################################################

Standing Algebra tracks fragility via StructuralDebt.

From Standing Algebra:

  • Drift represents tolerated perturbation, not correction.
  • Even bounded drift increases fragility over time.
  • Drift must therefore register as structural debt.

Ignoring debt allows slow collapse without witnesses.

Therefore:

  Drift must contribute to structural debt.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` increases
structural debt for agent `a` at state `s`.
-/
axiom DriftAccruesDebt : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Drift Structural Debt):

Drift operations must accrue structural debt.
-/
axiom drift_accrues_structural_debt :
  ∀ {D : Operation},
    DriftRegimeOp D →
    ∀ s : State,
      ∀ a : Agent,
        DriftAccruesDebt a D s

/--
Derived theorem:

Drift increases structural debt.
-/
theorem DriftAccruesStructuralDebt
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  ∀ s : State,
    ∀ a : Agent,
      DriftAccruesDebt a D s :=
by
  intros s a
  exact drift_accrues_structural_debt hDrift s a

end SigmaR
