import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.CapacityMeasure_Definition
import SigmaR.Valuation.Measures.Definitions.ExitViability_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Capacity Not Exit
###############################################################################

Capacity expresses ability or potential.
Exit viability is a structural predicate concerning refusal,
non-coercion, and the availability of escape.

No default implication from capacity measures to exit
viability is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating capacity measures as guaranteeing
or licensing exit viability is permitted.
-/
axiom capacity_not_exit :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsExitViableFromCapacityMeasure a s
  )

end SigmaR.Valuation.Measures.Independence
