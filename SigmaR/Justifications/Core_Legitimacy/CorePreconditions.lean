import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingExhaustiveness_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification

/-!
###############################################################################
# Core Preconditions for Legitimacy
###############################################################################

This file enforces that operations may not
enter legitimacy evaluation
unless publicly warranted structural
conditions are satisfied.

Where JustifiedCore enforces:

  Legitimate F → justified structure

CorePreconditions enforces:

  justified structure → admissibility

preventing:

  • belief‑driven coercion
  • unresolved frame constraint
  • aggregation without standing
  • exit collapse via dominant coupling
  • risk externalization
  • boundary leakage
  • irreversible coordination

from entering the legitimacy domain.
-/

namespace SigmaR

-- `Admissible` is the core admissibility predicate `Admissible : Operation → Prop`
-- of `SigmaR.StandingAlgebra_FormalCore`; it is imported, not redeclared here.

/--
Precondition:

Legitimacy evaluation
requires Perceptual Frame Agreement.
-/
axiom admissible_requires_pfa :
  ∀ {F : Operation} {s : State},
    Admissible F →
    PFA s

/--
Precondition:

Legitimacy evaluation
requires contestability.
-/
axiom admissible_requires_contestation :
  ∀ {F : Operation} {s : State},
    Admissible F →
    Contestable s

/--
Precondition:

Standing‑altering acts
require frame resolution.
-/
axiom admissible_requires_resolution :
  ∀ {F : Operation} {s : State},
    Admissible F →
    FrameResolved s

/--
Precondition:

Standing must be derived.
-/
axiom admissible_requires_derivation :
  ∀ {F : Operation} {s : State},
    Admissible F →
    DerivedStanding s

/--
Precondition:

Standing must be exposure‑indexed.
-/
axiom admissible_requires_risk_index :
  ∀ {F : Operation} {s : State},
    Admissible F →
    RiskIndexedStanding s

/--
Precondition:

Coupling must be exhaustively represented.
-/
axiom admissible_requires_coupling :
  ∀ {F : Operation} {s : State},
    Admissible F →
    CouplingExhaustive s

/--
Precondition:

Dominant coupling must be identifiable.
-/
axiom admissible_requires_dominance :
  ∀ {F : Operation} {s : State},
    Admissible F →
    DominantCouplingIdentified s

/--
Precondition:

Constraint must respect domain boundary.
-/
axiom admissible_requires_boundary :
  ∀ {F : Operation} {s : State},
    Admissible F →
    BoundaryRespected s

/--
Precondition:

Constraint must remain temporally rerunnable.
-/
axiom admissible_requires_rerunnable :
  ∀ {F : Operation} {s : State},
    Admissible F →
    Rerunnable s

end SigmaR
