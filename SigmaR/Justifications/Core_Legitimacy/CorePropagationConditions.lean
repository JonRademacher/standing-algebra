import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification
import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification
import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification
import SigmaR.Justifications.Core_Legitimacy.ExitViabilityMonotonicity
import SigmaR.Justifications.Core_Legitimacy.StructuralDebt_Justification
import SigmaR.StandingAlgebra_RegimeStacked

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
  ∀ {F : Operation} {a : Agent},
    Legitimate F →
    σ (apply F a) ≥ σ a

/--
Propagation:

Legitimate operations
must not increase
dominant dependency.
-/
axiom legitimacy_bounded_dependency :
  ∀ {F : Operation} {a : Agent},
    Legitimate F →
    deg (apply F a) ≤ deg a

/--
Propagation:

Legitimate operations
must not externalize risk.
-/
axiom legitimacy_preserves_risk :
  ∀ {F : Operation} {a : Agent},
    Legitimate F →
    RiskLoad (apply F a) ≤ RiskLoad a

/--
Propagation:

Legitimate operations
must preserve exit viability
from dominant coupling.
-/
axiom legitimacy_preserves_exit :
  ∀ {F : Operation} {a i : Agent} (θ : Agent → ℝ),
    Legitimate F →
    ExitViable θ a i →
    ExitViable θ (apply F a) i

/--
Propagation:

Autonomy‑reducing legitimate operations
must accumulate structural debt.
-/
axiom legitimacy_accumulates_debt :
  ∀ {F : Operation} {a : Agent},
    Legitimate F →
    σ (apply F a) < σ a →
    HasStructuralDebt F a

end SigmaR
