import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.Definitions.RiskInheritance_Definition
import SigmaR.Valuation.Measures.Definitions.StandingMeasure_Definition

open SigmaR.Valuation.Core

/-!
###############################################################################
# Independence: Risk Inheritance Not Standing
###############################################################################

Inherited or structural risk does not license or imply standing.

Risk inheritance captures exposure transmitted through structure,
history, or dependency.
Standing measures recognized status or admissible participation
within a system.

No default implication from risk inheritance to standing
is licensed.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Independence

/--
No implication treating risk inheritance as constituting
or licensing standing is permitted.
-/
axiom risk_not_standing :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsStandingFromRiskInheritance a s
  )

end SigmaR.Valuation.Measures.Independence
