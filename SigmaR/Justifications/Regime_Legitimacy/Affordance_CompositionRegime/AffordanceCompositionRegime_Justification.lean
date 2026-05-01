import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.NonSelectiveComposition_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.ExitPreservationUnderComposition_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.StandingMonotonicityUnderComposition_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.RiskAccumulationBound_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.ScopeIntegrityUnderComposition_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.SymmetricAffordanceExposure_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.RepairPreservationUnderComposition_Justification

/-!
###############################################################################
# Affordance Composition Regime Justification
###############################################################################

Standing Algebra treats affordances as locally legitimate
transformations of an agent’s available action space.

From Standing Algebra and On Relevance:

  • Legitimacy of individual affordances does not guarantee
    legitimacy of their composition.
  • Domination, coercion, and authority can emerge
    through the accumulation of locally admissible steps.
  • Therefore, affordance composition must be treated
    as a standing-relevant regime in its own right.

This regime enforces the following global constraints
under affordance composition:

  • Non-selection is preserved globally.
  • Exit availability is preserved globally.
  • Standing monotonicity is preserved globally.
  • Risk accumulation is bounded globally.
  • Scope integrity is preserved globally.
  • Affordance exposure remains symmetric.
  • Repair availability is preserved.

Affordance composition is legitimate if and only if
all of these structural constraints are satisfied.

Any composition violating one or more of these
conditions is illegitimate, regardless of the
local admissibility of its components.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` participates in the
Affordance Composition Regime.
-/
constant AffordanceCompositionRegimeOp : Operation → Prop

/--
Tier-2 regime declaration:

Affordance composition is a standing-relevant regime.
-/
axiom affordance_composition_is_regime :
  ∀ {G : Operation},
    AffordanceComposed G →
    AffordanceCompositionRegimeOp G

end SigmaR
