module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorDriftSensitivity_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Successor–Drift Sensitivity Justification
###############################################################################

Standing Algebra distinguishes successor-based change
from drift-based perturbation.

From Standing Algebra:

  • Successor change is discrete, standing-relevant,
    and successor-native.
  • Drift is bounded, non-strategic perturbation.
  • Drift may neither simulate successor increments
    nor negate successor constraints.

Allowing drift to accumulate or offset successor change
would reintroduce continuous dynamics, erosion,
or arithmetic smuggling.

Therefore:

  Successor constraints are insensitive to drift.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` performs successor-based
standing change for agent `a` at state `s`.
-/
constant SuccessorChange : Agent → Operation → State → Prop

/--
Predicate: operation `D` performs drift-based
perturbation for agent `a` at state `s`.
-/
constant DriftChange : Agent → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor–Drift Sensitivity):

Drift operations may not:
  • simulate successor change,
  • offset successor change,
  • or combine with successor operations
    to violate successor discipline.

Successor change remains discrete and dominant.
-/
axiom successor_drift_insensitive :
  ∀ {F D : Operation},
    SuccessorRegimeOp F →
    DriftRegimeOp D →
    ∀ s : State,
      ∀ a : Agent,
        SuccessorChange a F s →
        ¬ (DriftChange a D s ∧ SuccessorChange a (D ∘ F) s)

/--
Derived theorem:

Successor constraints are preserved under drift.
-/
theorem SuccessorDriftInsensitive
  {F D : Operation}
  (hSucc : SuccessorRegimeOp F)
  (hDrift : DriftRegimeOp D) :
  ∀ s : State,
    ∀ a : Agent,
      SuccessorChange a F s →
      ¬ (DriftChange a D s ∧ SuccessorChange a (D ∘ F) s) :=
by
  intros s a hSC
  exact successor_drift_insensitive hSucc hDrift s a hSC

end SigmaR
