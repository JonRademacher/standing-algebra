import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.BeliefNonAuthoritative_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification

/-!
###############################################################################
# Core Prohibitions on Legitimacy
###############################################################################

This file prevents operations
from entering the admissible domain
when they violate autonomy‑relevant
structural constraints.

Where CorePreconditions
require warranted structure,
CoreProhibitions
exclude operations that:

  • bind standing via belief,
  • aggregate under asymmetric exposure,
  • constrain under unresolved interpretation,
  • foreclose exit,
  • export constraint externally,
  • or produce irreversible autonomy loss.
-/

namespace SigmaR

/--
Prohibition:

Belief‑based claims
may not bind standing.
-/
axiom belief_cannot_bind :
  ∀ {F : Operation} {s : State},
    ¬ BeliefNonAuthoritative s →
    ¬ Legitimate F

/--
Prohibition:

Unresolved frames
may not authorize constraint.
-/
axiom unresolved_frames_block_constraint :
  ∀ {F : Operation} {s : State},
    ¬ FrameResolved s →
    ¬ Legitimate F

/--
Prohibition:

Standing must not
be aggregated
under asymmetric exposure.
-/
axiom aggregation_without_risk_invalid :
  ∀ {F : Operation} {s : State},
    ¬ RiskIndexedStanding s →
    ¬ Legitimate F

/--
Prohibition:

Constraint must not
foreclose exit
through dominant coupling.
-/
axiom dominant_exit_loss_invalid :
  ∀ {F : Operation} {s : State},
    ¬ DominantCouplingIdentified s →
    ¬ Legitimate F

/--
Prohibition:

Constraint must not
propagate beyond
represented domain.
-/
axiom boundary_violation_invalid :
  ∀ {F : Operation} {s : State},
    ¬ BoundaryRespected s →
    ¬ Legitimate F

/--
Prohibition:

Irreversible constraint
may not bind autonomy.
-/
axiom irreversibility_invalid :
  ∀ {F : Operation} {s : State},
    ¬ Rerunnable s →
    ¬ Legitimate F

end SigmaR
