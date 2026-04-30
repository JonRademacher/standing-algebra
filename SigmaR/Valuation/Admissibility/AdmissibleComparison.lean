import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Comparison
###############################################################################

This file governs when valuation measures may be compared
without implying aggregation, prioritization, or tradeoff.

It does NOT:
• authorize comparison
• assert comparability
• permit aggregation
• introduce optimization

It ONLY constrains admissible comparison patterns.
###############################################################################
-/

namespace SigmaR

/--
A comparison between valuation measures is admissible
under declared structural constraints.
-/
constant AdmissibleComparison : Measure → Measure → Prop

end SigmaR
