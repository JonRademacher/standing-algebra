import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Temporal Accumulation Not Domination Pressure
###############################################################################

Temporal accumulation does not license or imply domination pressure.

Temporal accumulation tracks irreversible or time-binding
structural constraint across states.
Domination pressure tracks proximity to systemic instability
or collapse.

No default implication from temporal accumulation to
domination pressure is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating temporal accumulation as constituting,
licensing, or collapsing into domination pressure
is permitted.
-/
axiom temporal_accumulation_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromTemporalAccumulation a s
  )

end SigmaR
