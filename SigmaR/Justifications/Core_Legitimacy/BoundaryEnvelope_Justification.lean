module SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification

import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Boundary Envelope
###############################################################################

Standing Algebra guarantees
autonomy preservation
only within its interpreted domain.

In *On Relevance*, coordination
across perceptual frame agreements (PFAs)
may propagate constraint
beyond local standing relations.

Accordingly:

  Actions taken within one scope
  may affect agents or identities
  outside the relevant PFA.

Such external effects may:

  • alter CIA‑indexed autonomy,
  • generate IEW,
  • or suppress exit viability

without being represented
in standing evaluation.

Failure to distinguish
in‑scope from out‑of‑scope impact
permits:

  • locally legitimate intervention,
  • producing externally
    autonomy‑reducing constraint.

This constitutes a legitimacy failure
arising from scope leakage.

At the Core level we therefore require:

  Any intervention functioning
  as public warrant
  must evaluate autonomy impact
  relative to the boundary
  of its interpreted domain.

This ensures that:

  • constraint does not propagate
    beyond represented standing,
  • IEW cannot arise
    from externalized harm,
  • and legitimacy remains
    scope‑governed.
-/

namespace SigmaR

/-- Predicate: the intervention
    at state `s` respects
    domain boundary
    of represented standing. -/
constant BoundaryRespected : State → Prop

/--
Core legitimacy axiom:

Public intervention must
respect the boundary envelope
of represented autonomy.
-/
axiom intervention_requires_boundary :
  ∀ s : State,
    BoundaryRespected s

end SigmaR
