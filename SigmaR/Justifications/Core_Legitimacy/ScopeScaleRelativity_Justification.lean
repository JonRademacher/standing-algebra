module SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification

import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Scope Sensitivity and Scale Relativity
###############################################################################

In *On Relevance*, Perceptual Frame Agreement (PFA) provides the
default empirical basis for public warrant under corrigible access
conditions.

However:

  • Standing is scale‑relative.
  • Interpretation varies across scopes.
  • No single interpretation dominates automatically.
  • Risk inheritance and pragmatic salience differ across agents.
  • IEW may emerge from cross‑scope coupling.

Accordingly:

  A claim may acquire legitimacy within a local PFA
  while failing to meet coupling requirements
  for broader public application.

Validated harm must therefore be evaluated
relative to those who bear the consequences
of acting upon it.

From *On Relevance*:

  • Interpretation authority tracks who bears the risk.
  • Non‑parochial evidence must be rerunnable across frames.
  • Autonomy is demonstrated structurally within PFA.
  • Coordination becomes constraint when
    local agreement is treated as global standing.

Failure to respect scope sensitivity permits:

  • stabilization of local PFAs as global warrant,
  • asymmetric CIA suppression across agents,
  • and legitimacy‑preserving structural injustice.

At the Core level we therefore require:

  Any standing, autonomy, or capacity claim
  that functions as public warrant
  must remain scope‑sensitive
  and scale‑relative to the relevant PFA.

This ensures that:

  • local agreement does not stabilize into
    global coercive authority,
  • autonomy‑preserving intervention remains
    publicly rerunnable,
  • and legitimacy remains corrigible across scales.
-/

namespace SigmaR

/-- Predicate: the standing at state `s`
    is evaluated relative to the relevant scope. -/
constant ScopeSensitive : State → Prop

/-- Predicate: autonomy claims at state `s`
    are scale‑relative across PFAs. -/
constant ScaleRelative : State → Prop

/--
Core legitimacy axiom:

If PFA functions as public warrant,
then standing, autonomy, and capacity
must remain scope‑sensitive
and scale‑relative.
-/
axiom pfa_requires_scope_scale :
  ∀ s : State,
    PFA s →
      ScopeSensitive s ∧
      ScaleRelative s

end SigmaR
