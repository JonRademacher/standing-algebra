module SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorRegime_Justification

import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorConsistency_Justification
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorAvailability_Justification
import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorNonDeprivation_Justification

/-!
###############################################################################
# Successor Regime Justification
###############################################################################

Standing Algebra is successor-native.

Standing is not a continuous quantity, nor an aggregative one.
All legitimate standing change occurs through discrete successor steps.

From Standing Algebra and On Relevance:

  • Successor-based change is standing-relevant.
  • Legitimacy is not closed under successor application.
  • Domination may arise through:
      - successor jumps,
      - successor denial,
      - successor freezing,
      - or asymmetric successor access,
    even when standing is never reduced.

Therefore:

  Successor change must be governed by an explicit regime
  with independent legitimacy constraints.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` participates in the
Successor Regime.

This marks operations whose legitimacy depends
on successor-based standing change constraints.
-/
constant SuccessorRegimeOp : Operation → Prop

/--
Tier-2 regime declaration:

Any operation that performs successor-based
standing change participates in the Successor Regime.
-/
axiom successor_is_regime :
  ∀ {F : Operation},
    SuccessorConsistent F →
    SuccessorRegimeOp F

end SigmaR
