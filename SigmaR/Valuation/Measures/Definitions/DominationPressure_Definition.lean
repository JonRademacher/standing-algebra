import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Domination Pressure — Definition (Optional Σᴿ⁺)
###############################################################################

DominationPressure is a diagnostic measure of
accumulated structural domination pressure.

• It is descriptive, not punitive or authorizing.
• It does not itself trigger action.
• Any properties or invariants are introduced elsewhere.
###############################################################################
-/

namespace SigmaR

/--
DominationPressure a is the successor-native measure
of accumulated domination pressure affecting agent a
(or designated system carriers in Σᴿ⁺).
-/
constant DominationPressure : Agent → Nat

end SigmaR
