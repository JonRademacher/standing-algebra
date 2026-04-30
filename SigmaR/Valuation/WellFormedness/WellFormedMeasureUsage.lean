import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Measure Usage
###############################################################################

This file defines structural constraints on *how* valuation measures
may be used once declared.

It does NOT:
• constrain conclusions
• assert legitimacy or authority
• permit intervention or action
• define admissibility

It ONLY prevents structural misuse of measures.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure must not be applied outside its declared
agent–state domain.
-/
constant MeasureUsedWithinDomain :
  Measure → Prop

/--
A measure declared as context-bound must not be used outside
that context.
-/
constant MeasureUsageRespectsContext :
  Measure → Prop

/--
Projected or restricted measures must not be used as if they
were original, unrestricted measures.
-/
constant MeasureUsageRespectsProjection :
  Measure → Prop

/--
Restricted measures must not be treated as globally scoped.
-/
constant MeasureUsageRespectsRestriction :
  Measure → Prop

end SigmaR
