module SigmaR.Justifications.Regime_Legitimacy.AdapterRegime.AdapterCompositionNonSelection_Justification

import SigmaR.Justifications.Core_Legitimacy.NonSelection_Justification
import SigmaR.Justifications.Core_Legitimacy.StandingMonotonicity
import SigmaR.Justifications.Regimes.AdapterRegime.AdapterRegime_Justification

/-!
###############################################################################
# Adapter Composition Non-Selection Justification
###############################################################################

Adapters in Σᴿ are mediating components, not sovereign operators.

From Standing Algebra and On Relevance:

  • Adapters may transform, translate, or relay proposals,
    but may not select outcomes.
  • This prohibition applies not only to individual adapters,
    but to adapter compositions.
  • No collection of adapters may collectively perform
    what no adapter may perform individually.

Otherwise, outcome selection, standing reduction, or exit collapse
could be laundered across a pipeline of locally admissible adapters.

Therefore:

  Adapter compositions must preserve non-selection and
  standing invariants globally, not merely locally.
###############################################################################
-/

namespace SigmaR

/--
Predicate: `G` is a composition of adapters that includes operation `F`
as a constituent step.

This predicate abstracts over the internal structure of adapter pipelines.
-/
constant AdapterComposed : Operation → Operation → Prop

/--
Tier-2 legitimacy axiom (Adapter Composition Non-Selection):

If an adapter operation is Legitimate,
then no adapter composition containing it
may perform outcome selection or reduce standing.

Non-selection must hold globally across adapter pipelines.
-/
axiom adapter_composition_non_selection :
  ∀ {F G : Operation},
    Legitimate F →
    AdapterComposed F G →
    NonSelecting G ∧ StandingMonotone G

/--
Derived theorem:

Legitimate adapters cannot participate in
selection-performing compositions.
-/
theorem AdapterCompositionPreservesNonSelection
  {F G : Operation}
  (hLeg : Legitimate F)
  (hComp : AdapterComposed F G) :
  NonSelecting G ∧ StandingMonotone G :=
by
  exact adapter_composition_non_selection hLeg hComp

end SigmaR
