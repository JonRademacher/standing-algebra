import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Measure Set
###############################################################################

This file defines admissibility of sets of valuation measures
used together in reasoning.

It does NOT:
• permit aggregation
• imply comparability
• impose prioritization
• allow tradeoffs

It ONLY governs permission to use a collection jointly.
###############################################################################
-/

namespace SigmaR

/--
A set of valuation measures is admissible for joint use
in reasoning.
-/
constant AdmissibleMeasureSet : Set Measure → Prop

end SigmaR
