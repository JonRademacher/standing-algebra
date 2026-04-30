module SigmaR.Justifications.Regime_Legitimacy.DriftRegime.BoundedDrift_Justification

import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Bounded Drift Justification
###############################################################################

Standing Algebra permits drift only as a bounded perturbation.

From Standing Algebra:

  • Drift represents small, non-strategic perturbations.
  • Drift is successor-bounded in standing and coupling degree.
  • Drift may not accumulate unbounded change.

Allowing unbounded or continuous drift would reintroduce
gradual domination and erosion through noise.

Therefore:

  Drift must be strictly bounded.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `D` is a bounded drift operation.
-/
constant BoundedDrift : Operation → Prop

/--
Tier-2 legitimacy axiom (Bounded Drift):

Any operation participating in the Drift Regime
must be bounded drift.
-/
axiom bounded_drift_required :
  ∀ {D : Operation},
    DriftRegimeOp D →
    BoundedDrift D

/--
Derived theorem:

Drift is bounded.
-/
theorem BoundedDriftRequired
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  BoundedDrift D :=
by
  exact bounded_drift_required hDrift

end SigmaR
