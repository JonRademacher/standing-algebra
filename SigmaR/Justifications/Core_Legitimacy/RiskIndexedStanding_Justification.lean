import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Risk‑Indexed Standing
###############################################################################

In *On Relevance*, standing is structurally
generated through autonomy‑relevant coupling.

However:

  Exposure to constraint
  may differ across agents.

Interpretation authority tracks:

  those who bear the risk
  of acting on the interpretation,

not those who assert belief
or participate in aggregation.

Validated harm must therefore
be evaluated relative to:

  those who face the consequences
  of acting upon it.

Aggregation alone:

  cannot confer standing
  under asymmetric exposure.

Failure to index standing
by exposure permits:

  • materially exposed minorities
    to be constrained,
  • under procedurally legitimate acts,
  • without meaningful
    validation channels.

This produces:

  • IEW via asymmetric
    constraint uptake.

At the Core level we therefore require:

  Standing to bind or constrain
  must scale relative to
  autonomy‑impacting exposure.

This ensures that:

  • materially exposed agents
    retain validation authority,
  • constraint tracks
    structural burden,
  • and legitimacy does not arise
    from symmetric aggregation.
-/

namespace SigmaR

/-- Predicate: standing at state `s`
    is indexed by exposure
    to autonomy‑impacting constraint. -/
constant RiskIndexedStanding : State → Prop

/--
Core legitimacy axiom:

Standing must scale
relative to exposure.
-/
axiom standing_requires_risk_index :
  ∀ s : State,
    RiskIndexedStanding s

end SigmaR
