import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification

/-!
###############################################################################
# Justification of Multi‑Scope Simultaneity
###############################################################################

In *On Relevance*, actions and harms may occur
relative to multiple perceptual frame agreements (PFAs)
simultaneously.

Examples include:

  • individual vs institutional exposure,
  • domain‑specific vs public interpretation,
  • local vs global coordination,
  • and cross‑layer coupling producing IEW.

Accordingly:

  • Standing is scale‑relative.
  • Interpretation authority tracks who bears risk.
  • Validated harm must be evaluated
    relative to those affected by action.

A claim may therefore:

  • satisfy PFA within one scope,
  • fail to satisfy PFA within another,
  • while action remains coupled across both.

Failure to evaluate multiple scopes concurrently permits:

  • local agreement to function as global warrant,
  • asymmetric CIA suppression across agents,
  • and legitimacy‑preserving structural injustice.

This constitutes a legitimacy failure
arising from cross‑scope coupling.

At the Core level we therefore require:

  Any claim functioning as public warrant
  must be evaluated relative to all PFAs
  affected by its consequences.

This ensures that:

  • local agreement cannot stabilize into
    cross‑scope coercive authority,
  • harm validation remains publicly rerunnable,
  • and legitimacy remains corrigible
    across simultaneous scales.
-/

namespace SigmaR

/-- Predicate: the claim at state `s`
    is evaluated across all relevant PFAs. -/
constant MultiScopeEvaluated : State → Prop

/--
Core legitimacy axiom:

If PFA functions as public warrant,
then it must be evaluated
across all relevant scopes.
-/
axiom pfa_requires_multiscope :
  ∀ s : State,
    PFA s →
    MultiScopeEvaluated s

end SigmaR
