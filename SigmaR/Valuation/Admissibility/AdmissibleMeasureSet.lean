import SigmaR.Valuation.Core.StructuralInterfaces

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

namespace SigmaR.Valuation.Admissibility

/--
A set of valuation measures is admissible for joint use
in reasoning.
-/
abbrev AdmissibleMeasureSet : Set SigmaR.Valuation.Core.Measure → Prop :=
  SigmaR.Valuation.Core.AdmissibleMeasureSet

end SigmaR.Valuation.Admissibility
