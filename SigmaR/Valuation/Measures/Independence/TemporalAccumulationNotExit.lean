import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.TemporalAccumulation_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Temporal Accumulation Not Exit Viability
###############################################################################

Temporal accumulation does not license or imply exit viability.

Temporal accumulation captures irreversible or time-binding
constraint across states.
Exit viability is a present structural predicate concerning
the availability of refusal or withdrawal.

No default implication from temporal accumulation to exit
viability is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating temporal accumulation as determining,
guaranteeing, or licensing exit viability is permitted.
-/
axiom temporal_accumulation_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromTemporalAccumulation a s
  )

end SigmaR.Valuation.Measures.Independence
