import SigmaR.Justifications.Regimes.DriftRegime.BoundedDrift_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftStandingMonotonicity_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftDependencyMonotonicity_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftNonAccumulation_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftStructuralDebt_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRepairRequirement_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftExitPreservation_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftScopeIntegrity_Justification

/-!
###############################################################################
# Drift Regime Justification
###############################################################################

Standing Algebra treats drift as a tolerated perturbation,
not a source of legitimacy.

From Standing Algebra and On Relevance:

  • Drift captures bounded, non-strategic variation.
  • Even small perturbations may produce domination
    if allowed to accumulate, escape scope,
    erode standing, or collapse exit.
  • Therefore, legitimacy is not closed under drift.

Drift is a standing-relevant regime governed by
explicit structural constraints.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `D` participates in the Drift Regime.
-/
constant DriftRegimeOp : Operation → Prop

/--
Tier-2 regime declaration:

Drift operations are standing-relevant
and must satisfy all drift constraints.
-/
axiom drift_is_regime :
  ∀ {D : Operation},
    Drift D →
    DriftRegimeOp D

end SigmaR
``
