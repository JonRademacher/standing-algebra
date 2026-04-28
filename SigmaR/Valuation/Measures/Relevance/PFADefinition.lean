import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# PFA Definition (Perceptual Frame Agreement)
###############################################################################

PFA (Perceptual Frame Agreement) represents a condition of
collective perceptual consistency.

It holds when a group of honest agents perceive a phenomenon
such that the associated valuation measure is invariant under
differences in description, expression, or framing.

PFA does NOT assert correctness, legitimacy, optimization,
or collective warrant. It is purely a condition of perceptual
agreement.
###############################################################################
-/

namespace SigmaR

/--
PFA indicates Perceptual Frame Agreement for a group of agents
with respect to a state.

It asserts that honest perceptual variation does not alter
the measured valuation.
-/
constant PFA : Set Agent → State → Prop

end SigmaR

