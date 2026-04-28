import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# No Metric Gaming
###############################################################################

The valuation system does not assume that metrics
can be gamed to achieve legitimate outcomes.
###############################################################################
-/

namespace SigmaR

/--
No metric gaming behavior is assumed.
-/
axiom no_metric_gaming :
  ¬ (∃ (G : Agent → State → State),
        True)

end SigmaR
