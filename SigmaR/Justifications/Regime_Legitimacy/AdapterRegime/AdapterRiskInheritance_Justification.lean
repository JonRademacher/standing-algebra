import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification
import SigmaR.Justifications.Regimes.Adapter.AdapterInference_Justification

/-!
###############################################################################
# Justification of Adapter Risk Inheritance
###############################################################################

The Adapter Regime permits translation
of standing‑relevant claims
across perceptual frame agreements (PFAs).

In *On Relevance*:

  • Interpretation authority tracks
    those who bear the risk
    of acting on interpretation.

  • Validated harm must be evaluated
    relative to those who face
    the consequences of action.

Accordingly:

  Standing authorized within one PFA
  may be translated
  across PFAs via adapters.

Failure to preserve
risk inheritance across translation
permits:

  • constraint authorized
    in one scope,
  • applied in another,
  • with exposure borne externally.

This constitutes legitimacy failure
via cross‑scope burden transfer
and may generate IEW
through coordinated misalignment.

At the justification layer
we therefore require:

  Any adapter‑mediated inference
  affecting autonomy or standing
  must preserve
  exposure‑indexed risk
  across PFAs.

This ensures that:

  • standing cannot travel
    without risk,
  • constraint does not
    externalize burden,
  • and legitimacy remains
    exposure‑sensitive
    across translation.
-/

namespace SigmaR

/-- Predicate: adapter inference
    at state `s`
    preserves risk inheritance
    across PFAs. -/
constant AdapterRiskInherited : State → Prop

/--
Regime legitimacy axiom:

Adapter inference must
preserve exposure‑indexed risk.
-/
axiom adapter_requires_risk :
  ∀ s : State,
    AdapterRiskInherited s

end SigmaR
