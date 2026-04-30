module SigmaR.Justifications.Regime_Legitimacy.AdapterRegime.AdapterInterference_Justification

import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification

/-!
###############################################################################
# Justification of Adapter Inference
###############################################################################

The Adapter Regime permits interpretation
and translation of claims
across perceptual frame agreements (PFAs).

In *On Relevance*:

  • Interpretation may vary across scopes
    due to different risk inheritance,
    background norms,
    or pragmatic salience.

  • No single interpretation
    automatically dominates
    across PFAs.

Adapters therefore introduce:

  PFA₁ → Interpretation → Translation → PFA₂

which may:

  • alter CIA‑indexed autonomy,
  • misalign constraint
    with material exposure,
  • or stabilize IEW
    under cross‑scope coordination.

Failure to distinguish
interpretive translation
from publicly coupled warrant
permits:

  • constraint applied
    under scope mismatch,
  • standing altered
    via adapter uptake,
  • and legitimacy failure
    across PFAs.

At the justification layer
we therefore require:

  Any adapter‑mediated inference
  affecting autonomy or standing
  must preserve coupling
  across relevant PFAs.

This ensures that:

  • interpretation does not
    substitute for validation,
  • cross‑scope translation
    remains risk‑indexed,
  • and legitimacy does not arise
    from semantic mapping alone.
-/

namespace SigmaR

/-- Predicate: adapter inference
    at state `s`
    preserves autonomy‑relevant coupling
    across PFAs. -/
constant AdapterCoupled : State → Prop

/--
Regime legitimacy axiom:

Adapter inference must
preserve coupling
across PFAs.
-/
axiom adapter_requires_coupling :
  ∀ s : State,
    AdapterCoupled s

end SigmaR
