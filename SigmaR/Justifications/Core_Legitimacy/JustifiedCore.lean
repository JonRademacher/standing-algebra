import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.BeliefNonAuthoritative_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingExhaustiveness_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justified Core Alignment
###############################################################################

This file connects the normative justification layer
to the operational Core of Standing Algebra.

Each bridge axiom ensures that any operation
classified as Legitimate must satisfy
the publicly warranted structural conditions
derived from:

  • Perceptual Frame Agreement (PFA)
  • Contestability
  • Frame Resolution
  • Scope / Scale Sensitivity
  • Multi‑Scope Evaluation
  • Transition Rerunnability
  • Derived Standing
  • Risk‑Indexed Standing
  • Coupling Exhaustiveness
  • Coupling Typing
  • Dominant Coupling
  • Boundary Respect

This ensures that:

  Legitimate F
    implies publicly coupled warrant
    across autonomy‑relevant structure.

Without these bridges,
Σᴿ Core theorems would reason
over legitimacy
without enforcing
normative admissibility.
-/

namespace SigmaR

/--
Legitimate operations must arise
under Perceptual Frame Agreement.
-/
axiom legitimacy_requires_pfa :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    PFA s

/--
Legitimate operations must remain contestable.
-/
axiom legitimacy_requires_contestation :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    Contestable s

/--
Standing‑altering acts require
public frame resolution.
-/
axiom legitimacy_requires_resolution :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    FrameResolved s

/--
Legitimate constraint must remain
scope‑sensitive and scale‑relative.
-/
axiom legitimacy_requires_scope_scale :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    ScopeSensitive s ∧ ScaleRelative s

/--
Legitimate intervention must be
evaluated across relevant PFAs.
-/
axiom legitimacy_requires_multiscope :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    MultiScopeEvaluated s

/--
Legitimate standing must derive
from autonomy‑bearing agents.
-/
axiom legitimacy_requires_derivation :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    DerivedStanding s

/--
Legitimate standing must scale
with exposure.
-/
axiom legitimacy_requires_risk_index :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    RiskIndexedStanding s

/--
Autonomy‑relevant coupling
must be exhaustively represented.
-/
axiom legitimacy_requires_coupling_exhaustive :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    CouplingExhaustive s

/--
Constraint‑propagating coupling
must admit a dominant type.
-/
axiom legitimacy_requires_dominance :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    DominantCouplingIdentified s

/--
Legitimate intervention must respect
domain boundary.
-/
axiom legitimacy_requires_boundary :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    BoundaryRespected s

/--
Legitimate intervention must remain
temporally rerunnable.
-/
axiom legitimacy_requires_rerunnable :
  ∀ {F : Operation} {s : State},
    Legitimate F →
    Rerunnable s

end SigmaR
