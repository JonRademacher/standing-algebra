import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Measure Usage
###############################################################################

This file governs how admissible measures may be used
once admitted.

It does NOT:
• permit inference
• permit intervention
• imply authority
• define outcomes

It ONLY constrains structurally permissible usage.
###############################################################################
-/

namespace SigmaR.Valuation.Admissibility

/--
An admissible measure is used only within its declared domain
and scope.
-/
axiom AdmissibleMeasureUsage : Measure → Prop

end SigmaR.Valuation.Admissibility
