import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation ≠ Consent
###############################################################################

This file establishes that temporal accumulation does not entail
the absence of consent.

Consent reflects voluntary participation at a given state.
Temporal accumulation reflects irreversible or narrowing
structural constraint across states.

Importing this file explicitly rejects any assumption that
accumulated structural harm negates consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from temporal accumulation
to the absence of consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom temporal_accumulation_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       TemporalAccumulation a s → ¬ ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- long-term harm invalidates agreement
- irreversible constraint negates consent by definition
- voluntariness collapses into historical damage

Temporal accumulation and consent are distinct structural facts.
-/
