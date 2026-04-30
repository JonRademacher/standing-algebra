module SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftSctructuralDebt_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

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
constant DriftAccruesDebt : Agent → Operation → State → Prop

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
theorem DriftAccruesDebt
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  ∀ s : State,
    ∀ a : Agent,
      DriftAccruesDebt a D s :=
by
  intros s a
  exact drift_accrues_structural_debt hDrift s a

end SigmaR
