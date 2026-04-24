import SigmaR.Justifications.Core_Legitimacy.NonSelection_Justification
import SigmaR.Justifications.Regimes.Affordance_CompositionRegime.AffordanceCompositionRegime_Justification

/-!
###############################################################################
# Non-Selective Affordance Composition Justification
###############################################################################

Standing Algebra treats affordances as locally legitimate
transformations of available action space.

From Standing Algebra and On Relevance:

  • Legitimate constraints filter impermissible actions;
    they do not select outcomes.
  • This non-selection requirement applies not only
    to individual affordances, but to their composition.
  • Outcome selection may not emerge by accumulation
    of locally admissible affordances.

Otherwise, authority would reappear in soft form:
no single step would select an outcome,
yet the composed affordance space would.

This constitutes domination by design.

Therefore:

  Affordance composition must preserve non-selection globally.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` is a composition of affordance operations,
each individually admissible.

This abstracts over finite sequences, pipelines,
or structured compositions of affordances.
-/
constant AffordanceComposed : Operation → Prop

/--
Tier-2 legitimacy axiom (Non-Selective Composition):

If every component affordance is non-selective,
then their composition must also be non-selective.

Outcome selection may not emerge by composition.
-/
axiom non_selective_under_composition :
  ∀ {G : Operation},
    AffordanceComposed G →
    (∀ F : Operation, ComponentOf F G → NonSelecting F) →
    NonSelecting G

/--
Derived theorem:

Affordance compositions preserve non-selection.
-/
theorem NonSelectiveComposition
  {G : Operation}
  (hComp : AffordanceComposed G)
  (hNS : ∀ F : Operation, ComponentOf F G → NonSelecting F) :
  NonSelecting G :=
by
  exact non_selective_under_composition hComp hNS

end SigmaR
