module SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification

import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification

/-!
###############################################################################
# Justification of Derived Standing
###############################################################################

In *On Relevance*, standing is defined as:

  the structural legitimacy to bind,
  constrain, authorize, or obligate.

Standing arises via:

  public, autonomy‑relevant coupling,

not through:

  belief,
  aggregation,
  authority,
  or positional power.

Primary standing is held
only by individuals
with terminal agency.

Institutions, collectives,
and social actors:

  hold derivative standing
  borrowed from individuals
  for coordination.

Such standing:

  • is propagated through coupling,
  • remains revocable by risk‑bearers,
  • and collapses if exit
    or correction is foreclosed.

Aggregation alone:

  cannot confer standing
  under asymmetric exposure.

Failure to distinguish
primary from derived standing
permits:

  • proxy or institutional authority
    to bind autonomy
    without agent‑level validation,

producing:

  • structural IEW,
  • exit collapse,
  • and legitimacy failure
    under procedural symmetry.

At the Core level we therefore require:

  Any collective or institutional
  authority must derive standing
  from autonomy‑bearing agents
  through publicly coupled operations.

This ensures that:

  • coordination does not simulate
    coercive legitimacy,
  • materially exposed minorities
    retain validation channels,
  • and standing propagates only
    through autonomy‑relevant coupling.
-/

namespace SigmaR

/-- Predicate: collective standing
    at state `s`
    is derived from
    autonomy‑bearing agents. -/
constant DerivedStanding : State → Prop

/--
Core legitimacy axiom:

Institutional authority
must derive standing
from agent‑level coupling.
-/
axiom standing_requires_derivation :
  ∀ s : State,
    DerivedStanding s

end SigmaR
