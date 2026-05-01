import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification

/-!
###############################################################################
# Justification of Transition Criteria Rerunnability
###############################################################################

In *On Relevance*, legitimacy depends upon
transition criteria that are:

  • non‑parochial,
  • evidence‑based,
  • and rerunnable across PFAs.

Autonomy is demonstrated structurally
when these criteria emerge within
a perceptual frame agreement (PFA),
not asserted privately.

Accordingly:

  Any constraint justified under
  validated harm must remain
  revisable under updated
  perceptual concordance.

Failure to rerun transition criteria
across time permits:

  • coordination to persist
    beyond justification,
  • constraint to stabilize
    into structure,
  • and standing to be altered
    permanently.

This constitutes a legitimacy failure
and may generate Independently
Emergent Wrong (IEW).

At the Core level we therefore require:

  Any standing, autonomy,
  or intervention trigger
  that functions as public warrant
  must be reevaluable under
  updated PFA across time.

This ensures that:

  • constraint does not persist
    after justification expires,
  • harm validation remains
    publicly rerunnable,
  • and legitimacy remains
    temporally corrigible.
-/

namespace SigmaR

/-- Predicate: transition criteria
    at state `s` remain rerunnable
    under updated PFAs. -/
constant Rerunnable : State → Prop

/--
Core legitimacy axiom:

If PFA functions as public warrant,
then transition criteria must
remain rerunnable.
-/
axiom pfa_requires_rerunnability :
  ∀ s : State,
    PFA s →
    Rerunnable s

end SigmaR
