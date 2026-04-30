module SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification

import SigmaR.Justifications.Core_Legitimacy.PFA_Justification

/-!
###############################################################################
# Justification of Contestation Condition
###############################################################################

In *On Relevance*, Perceptual Frame Agreement (PFA) provides the
default empirical basis for public warrant under corrigible
access conditions.

However:

  • PFA is not a metaphysical truth‑maker.
  • PFA is provisional and revisable.
  • PFA must remain rerunnable across frames.
  • Non‑parochial evidence must not be controlled
    solely by the claimant.

From *On Relevance*:

  • Transition criteria must be non‑parochial,
    evidence‑based, and rerunnable.
  • Autonomy is demonstrated structurally within PFA,
    not asserted privately.
  • Forced misrecognition against PFA
    constitutes a standing violation.
  • Coordination becomes constraint
    when PFA cannot be contested.

Accordingly:

  PFA must remain open to contestation
  in order to function as public warrant.

Uncontestable PFA:

  • prevents revision,
  • stabilizes coordination into constraint,
  • and converts provisional agreement
    into structural standing.

This constitutes a legitimacy failure
and may generate Independently Emergent Wrong (IEW).

At the Core level we therefore require:

  Any state in which PFA functions
  as evidential warrant must permit
  contestation across perceptual frames.

This ensures that public warrant
remains corrigible over time.
-/

namespace SigmaR

/-- Predicate: the perceptual frame agreement
    at state `s` remains contestable. -/
constant Contestable : State → Prop

/--
Core legitimacy axiom:

If PFA functions as evidential warrant,
then it must remain contestable.
-/
axiom pfa_requires_contestation :
  ∀ s : State,
    PFA s →
    Contestable s

end SigmaR
