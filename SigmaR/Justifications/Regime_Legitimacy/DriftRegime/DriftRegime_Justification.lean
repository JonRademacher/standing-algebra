import SigmaR.Regimes.StandingAlgebra_DriftRegime
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.BoundedDrift_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftStandingMonotonicity_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftDependencyMonotonicity_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftNonAccumulation_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftStructuralDebt_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftRepairRequirement_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftExitPreservation_Justification
import SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftScopeIntegrity_Justification

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
Tier-2 regime declaration:

Drift operations are standing-relevant
and must satisfy all drift constraints.
-/
axiom drift_is_regime :
  ∀ {D : Operation},
    Drift D →
    DriftRegimeOp D

end SigmaR
