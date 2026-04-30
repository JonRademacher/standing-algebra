module SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftNonAccumulation_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Drift Non-Accumulation Justification
###############################################################################

Standing Algebra permits drift only as a bounded perturbation.

From Standing Algebra:

  • Drift is non-strategic and bounded.
  • Repeated drift steps may not accumulate
    unbounded standing loss, dependency, or risk.
  • Accumulation of bounded perturbations
    constitutes domination by iteration.

Therefore:

  Drift must be non-accumulative under repetition.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` is non-accumulative
under repeated application.
-/
constant NonAccumulatingDrift : Operation → Prop

/--
Tier-2 legitimacy axiom (Drift Non-Accumulation):

Drift operations must not accumulate harm
under repetition.
-/
axiom drift_non_accumulating :
  ∀ {D : Operation},
    DriftRegimeOp D →
    NonAccumulatingDrift D

/--
Derived theorem:

Drift does not accumulate harm.
-/
theorem DriftNonAccumulating
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  NonAccumulatingDrift D :=
by
  exact drift_non_accumulating hDrift

end SigmaR
