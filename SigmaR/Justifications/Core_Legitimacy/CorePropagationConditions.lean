module SigmaR.Justifications.Core_Legitimacy.CorePropagationConditions

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification

/-!
###############################################################################
# Core Propagation Conditions
###############################################################################

This file enforces that legitimate operations
propagate autonomy‑preserving structure
into standing‑relevant system state.

Where:

  CorePreconditions
    gate admissibility,

  JustifiedCore
    enforces warranted legitimacy,

  CoreProhibitions
    block illegitimate constraint,

CorePropagationConditions
ensures that legitimate operations:

  • preserve or increase standing,
  • do not increase dependency,
  • do not externalize risk,
  • do not foreclose exit,
  • and accumulate structural debt
    when autonomy is reduced.

This aligns operational state
with normative legitimacy.
-/

namespace SigmaR

/--
Propagation:

Legitimate operations
must preserve CIA‑indexed standing.
-/
axiom legitimacy_preserves_standing :
  ∀ {F : Operation} {s : State} {i : Agent},
    Legitimate F →
    σ (apply F s) i ≥ σ s i

/--
Propagation:

Legitimate operations
must not increase
dominant dependency.
-/
axiom legitimacy_bounded_dependency :
  ∀ {F : Operation} {s : State} {i : Agent},
    Legitimate F →
    deg (apply F s) i ≤ deg s i

/--
Propagation:

Legitimate operations
must not externalize risk.
-/
axiom legitimacy_preserves_risk :
  ∀ {F : Operation} {s : State} {i : Agent},
    Legitimate F →
    RiskLoad (apply F s) i ≤ RiskLoad s i

/--
Propagation:

Legitimate operations
must preserve exit viability
from dominant coupling.
-/
axiom legitimacy_preserves_exit :
  ∀ {F : Operation} {s : State} {i : Agent},
    Legitimate F →
    ExitViable (apply F s) i

/--
Propagation:

Autonomy‑reducing legitimate operations
must accumulate structural debt.
-/
axiom legitimacy_accumulates_debt :
  ∀ {F : Operation} {s : State} {i : Agent},
    Legitimate F →
    σ (apply F s) i < σ s i →
    StructuralDebt (apply F s) i > StructuralDebt s i

end SigmaR
