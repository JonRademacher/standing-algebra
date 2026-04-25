import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Temporal Accumulation — Definition
###############################################################################

TemporalAccumulation is a valuation-level diagnostic capturing
time-binding, irreversibility, and narrowing of future admissible
possibilities.

Source alignment:
• Standing Algebra (Σᴿ): time is successor-native and structural,
  not metric, not probabilistic, and not authoritative.
• On Relevance: long-term harm and temporal asymmetry are not
  reducible to risk, debt, or standing loss.

This file introduces NO dynamics, NO norms, NO urgency authority.
###############################################################################
-/

namespace SigmaR

/--
TemporalAccumulation a s is a successor-native valuation
representing accumulated irreversible constraint affecting
agent a in state s.

Higher values indicate greater temporal binding or loss
of future admissible freedom.
-/
constant TemporalAccumulation : Agent → State → Nat

end SigmaR
