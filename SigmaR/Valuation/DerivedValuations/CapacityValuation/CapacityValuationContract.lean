import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Capacity Valuation Contract
###############################################################################

This file defines the governing interpretive rules of the
Capacity Valuation sub-layer in SigmaR.

Capacity valuation:
• evaluates effective, usable capacity under structural,
  contextual, and agreement-mediated conditions
• does not redefine structural capacity from the Formal Core
• supports both internal and external capacity agreement
• incorporates load, consumption, saturation, and collapse
• encodes capacity-progress as a boundary condition,
  not a preference or selection rule
• treats omission of available capacity-progress as a
  structural constraint, not moral fault
• does not imply competence, merit, legitimacy, or authority
• does not authorize intervention or coercive action
• respects Independence, Monotonicity, Admissibility,
  and ResponseSemantics
• is always explicitly scoped

This file introduces no axioms.
###############################################################################
-/

namespace SigmaR

/--
The Capacity Valuation layer is governed by an explicit
interpretive contract defining its scope and limits.
-/
constant CapacityValuationContract : Prop

end SigmaR
