import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Capacity Measure — Definition
###############################################################################

Defines a valuation-level measure of agent capacity.
Capacity is distinct from standing and is not substitutable for it.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
Capacity measure for an agent in a given state.

This reflects structural capability or autonomy bandwidth,
not authority or merit.
-/
axiom CapacityMeasure : Agent → State → Nat

end SigmaR.Valuation.Measures.Definitions
