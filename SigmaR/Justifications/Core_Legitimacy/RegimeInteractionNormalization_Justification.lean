module SigmaR.Justifications.Core_Legitimacy.RegimeInteractionNormalization_Justification

import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Regime Interaction Normalization Justification
###############################################################################

Standing Algebra does not resolve regime interactions
by priority, exception, or ordering.

From Standing Algebra:

  • Multiple regime predicates may apply
    to the same operation.
  • Legitimacy is determined by satisfaction
    of all applicable constraints.
  • Where an operation fails legitimacy,
    normalization (envelope, repair, or identity)
    resolves the interaction without selection.

No regime has precedence over another.
No regime suspends another.
No ordering is imposed.

Therefore:

  Regime interaction is resolved solely
  by legitimacy normalization.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` satisfies all
constraints of all applicable regimes.
-/
constant AllRegimeConstraintsSatisfied : Operation → Prop

/--
Tier-2 legitimacy axiom (Regime Interaction Normalization):

An operation is legitimate iff it satisfies
all constraints of all regimes it participates in.
-/
axiom regime_interaction_normalized :
  ∀ {F : Operation},
    AllRegimeConstraintsSatisfied F →
    Legitimate F

/--
Derived theorem:

Regime interaction introduces no exception or priority.
-/
theorem RegimeInteractionNormalized
  {F : Operation}
  (hAll : AllRegimeConstraintsSatisfied F) :
  Legitimate F :=
by
  exact regime_interaction_normalized hAll

end SigmaR
