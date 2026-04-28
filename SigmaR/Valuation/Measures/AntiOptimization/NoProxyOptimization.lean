import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Proxy Optimization
###############################################################################

No valuation measure is assumed to be a valid proxy
for optimizing another measure.
###############################################################################
-/

namespace SigmaR

/--
No proxy-based optimization is assumed.
-/
axiom no_proxy_optimization :
  ¬ (∃ (P : Agent → State → Nat)
        (T : Agent → State → Nat),
        True)

end SigmaR
