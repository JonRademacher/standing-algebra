module SigmaR.Justifications.Regime_Legitimacy.AdapterRegime.AdapterContestability_Justification

import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Regimes.Adapter.AdapterInference_Justification

/-!
###############################################################################
# Justification of Adapter Contestability
###############################################################################

The Adapter Regime permits interpretation
and translation of claims
across perceptual frame agreements (PFAs).

In *On Relevance*:

  • Interpretation authority tracks
    those who bear the risk
    of acting on interpretation.

  • No single interpretation
    automatically dominates
    across PFAs.

Accordingly:

  Claims validated within one PFA
  may not bind standing
  in another PFA
  absent local contestation.

Failure to preserve contestability
across translation permits:

  • constraint applied
    under unresolved interpretation,
  • standing altered
    without local validation,
  • and IEW arising
    from coordinated misrecognition.

This constitutes legitimacy failure
via adapter‑mediated capture.

At the justification layer
we therefore require:

  Any adapter‑mediated inference
  affecting autonomy or standing
  must preserve contestability
  within the target PFA.

This ensures that:

  • interpretation does not
    substitute for validation,
  • constraint does not
    precede local evaluation,
  • and legitimacy remains
    publicly rerunnable
    across scopes.
-/

namespace SigmaR

/-- Predicate: adapter inference
    at state `s`
    preserves contestability
    within the target PFA. -/
constant AdapterContestable : State → Prop

/--
Regime legitimacy axiom:

Adapter inference must
preserve contestability
in the target scope.
-/
axiom adapter_requires_contestation :
  ∀ s : State,
    AdapterContestable s

end SigmaR
