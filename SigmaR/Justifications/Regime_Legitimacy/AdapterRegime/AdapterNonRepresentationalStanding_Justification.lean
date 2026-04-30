module SigmaR.Justifications.Regime_Legitimacy.AdapterRegime.AdapterNonRepresentationalStanding_Justification

import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification
import SigmaR.Justifications.Regimes.AdapterRegime.AdapterRegime_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskInheritance_Justification

/-!
###############################################################################
# Adapter Non-Representational Standing Justification
###############################################################################

Adapters in Σᴿ may not claim representational standing
or proxy warrant by default.

From Standing Algebra and On Relevance:

  • Authorization does not imply standing.
  • Representation requires validated coupling to risk-bearers.
  • Treating adapters as representatives without such coupling
    constitutes standing laundering.

Therefore:

  Adapters may not claim standing, warrant, or representational authority
  unless standing is independently validated through
  risk inheritance and justification.
###############################################################################
-/

namespace SigmaR

/--
Predicate: adapter operation `F` claims to represent agent `a`
in a standing-relevant way.
-/
constant AdapterClaimsRepresentation : Operation → Agent → Prop

/--
Tier-2 legitimacy axiom (Adapter Non-Representational Standing):

If an adapter operation is Legitimate,
then it may not claim representational standing
for an agent unless that agent inherits risk
from the operation.

Representation without risk coupling is illegitimate.
-/
axiom adapter_non_representational_standing :
  ∀ {F : Operation},
    Legitimate F →
    ∀ a : Agent,
      AdapterClaimsRepresentation F a →
      RiskInheritance a F →
      False

/--
Derived theorem:

Legitimate adapters cannot claim proxy standing
without validated risk inheritance.
-/
theorem AdapterCannotLaunderStanding
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ a : Agent,
    AdapterClaimsRepresentation F a →
    RiskInheritance a F →
    False :=
by
  intros a hRep hRisk
  exact adapter_non_representational_standing hLeg a hRep hRisk

end SigmaR
