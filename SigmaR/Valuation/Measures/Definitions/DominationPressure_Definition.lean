import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Domination Pressure — Definition (Optional Σᴿ⁺)
###############################################################################

DominationPressure is a diagnostic measure of
accumulated structural domination pressure.

Source alignment:
  • Standing Algebra: domination pressure signals
    approach to collapse regimes.
  • It is not punitive, normative, or authorizing.
  • It does not itself trigger action.

This file defines the measure only.
###############################################################################
-/

namespace SigmaR

/--
DominationPressure a is the successor-native measure
of accumulated domination pressure affecting agent a
(or designated system carriers in Σᴿ⁺).
-/
constant DominationPressure : Agent → Nat

/--
Domination pressure is always well-defined and non-negative.
-/
axiom DominationPressure_nonneg :
  ∀ a : Agent, 0 ≤ DominationPressure a

end SigmaR
