module SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification

import SigmaR.Justifications.Core_Legitimacy.PFA_Justification
import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification
import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification

/-!
###############################################################################
# Justification of Public Frame Resolution
###############################################################################

Standing Algebra requires that
non‑emergency public acts
that alter standing
be frame‑resolved.

In *On Relevance*,
interpretation of claims
must stabilize sufficiently
for comparison to a
Perceptual Frame Agreement (PFA).

Accordingly:

  Constraint applied prior
  to interpretive stabilization
  may alter standing
  without publicly
  coupled warrant.

Forced misrecognition
constitutes a standing violation
and may generate IEW.

Failure to resolve
relevant perceptual frames
permits:

  • belief‑driven constraint,
  • standing alteration
    under unresolved interpretation,
  • and legitimacy failure
    via coordinated misrecognition.

At the Core level we therefore require:

  Any public act
  that binds autonomy
  or alters standing
  must follow
  sufficient resolution
  of relevant PFAs.

This ensures that:

  • constraint does not precede
    interpretation,
  • standing remains
    publicly evaluable,
  • and legitimacy remains
    frame‑governed.
-/

namespace SigmaR

/-- Predicate: relevant PFAs
    at state `s`
    have stabilized sufficiently
    for public constraint. -/
constant FrameResolved : State → Prop

/--
Core legitimacy axiom:

Standing‑altering
public acts
require frame resolution.
-/
axiom constraint_requires_resolution :
  ∀ s : State,
    FrameResolved s

end SigmaR
