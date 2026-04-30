import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Measure
###############################################################################

This file defines when a single valuation measure may be used
in reasoning.

Admissibility does NOT imply:
• truth
• validity
• legitimacy
• authority
• relevance

It ONLY permits use under declared constraints.
###############################################################################
-/

namespace SigmaR

/--
A valuation measure is admissible for use in reasoning.
-/
constant AdmissibleMeasure : Measure → Prop

end SigmaR
