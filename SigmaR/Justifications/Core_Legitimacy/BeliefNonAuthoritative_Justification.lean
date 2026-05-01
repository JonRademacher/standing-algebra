import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification

/-!
###############################################################################
# Justification of Belief Non‑Authoritativeness
###############################################################################

In *On Relevance*, belief reports
and interpretive claims:

  • may compress uncertainty,
  • coordinate provisional action,
  • or guide evaluation.

However:

  Belief alone does not impart
  public standing.

Knowledge claims that do not align
with Perceptual Frame Agreement (PFA)
may guide action without
acquiring standing to bind or coerce.

Interpretation authority tracks:

  those who bear the risk
  of acting on the interpretation,

not those who assert belief.

Accordingly:

  Testimony or belief
  may initiate evaluation
  but may not determine:

    • legitimacy,
    • standing,
    • or coercive authority.

Failure to distinguish belief
from publicly coupled warrant
permits:

  • constraint applied
    under incomplete concordance,
  • standing altered
    via interpretive uptake,
  • and IEW arising
    from coordinated misrecognition.

At the Core level we therefore require:

  Any standing‑altering
  intervention must derive
  from publicly coupled warrant,
  not belief reports alone.

This ensures that:

  • interpretation cannot
    substitute for validation,
  • coercion cannot arise
    from belief,
  • and legitimacy remains
    publicly rerunnable.
-/

namespace SigmaR

/-- Predicate: standing‑altering
    action at state `s`
    is not belief‑based. -/
constant BeliefNonAuthoritative : State → Prop

/--
Core legitimacy axiom:

Belief alone may not
generate standing.
-/
axiom belief_requires_coupling :
  ∀ s : State,
    BeliefNonAuthoritative s

end SigmaR
