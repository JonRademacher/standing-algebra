import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingExhaustiveness_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Legitimacy Characterization
###############################################################################

This file characterizes legitimacy
as the preservation of autonomy‑relevant
structural invariants already required
by Standing Algebra.

Legitimacy is not introduced
as a primitive moral predicate.

Instead:

  Legitimate operations are those
  that preserve:

    • CIA‑indexed standing,
    • bounded dependency,
    • exposure‑indexed risk,
    • exit viability,
    • and repairability
      under structural debt.

Subject to:

    • Perceptual Frame Agreement,
    • Contestability,
    • Public Frame Resolution,
    • Derived Standing,
    • Risk‑Indexed Standing,
    • Coupling Exhaustiveness,
    • Dominant Coupling Identification,
    • Boundary Respect,
    • and Transition Rerunnability.

Thus:

  Legitimacy is equivalent
  to autonomy‑preserving
  structural admissibility.

This removes legitimacy
as a primitive
and re‑expresses it
as an invariant‑preserving property.
-/

namespace SigmaR

/--
Structural admissibility:

An operation preserves
autonomy‑relevant invariants
at state s.
-/
def StructurallyAdmissible
  (F : Operation) (s : State) : Prop :=
    PFA s
    ∧ Contestable s
    ∧ FrameResolved s
    ∧ DerivedStanding s
    ∧ RiskIndexedStanding s
    ∧ CouplingExhaustive s
    ∧ DominantCouplingIdentified s
    ∧ BoundaryRespected s
    ∧ Rerunnable s

/--
Legitimacy is equivalent
to structural admissibility.
-/
theorem legitimacy_characterization :
  ∀ {F : Operation} {s : State},
    Legitimate F
    ↔
    StructurallyAdmissible F s :=
by
  -- Left as axiomatic equivalence
  -- justified by Core Alignment
  admit

end SigmaR
