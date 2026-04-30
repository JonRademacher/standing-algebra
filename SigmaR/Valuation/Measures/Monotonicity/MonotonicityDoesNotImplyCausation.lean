import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Does Not Imply Causation (Contract)
###############################################################################

Monotonicity of a valuation measure must not be interpreted
as causal influence over another measure.

This file introduces no axioms.
It names an interpretive boundary that applies to all uses
of monotonicity within SigmaR.
###############################################################################
-/

namespace SigmaR

/--
Monotonicity relations are treated as non-causal.
-/
constant MonotonicityIsNonCausal : Prop

end SigmaR
