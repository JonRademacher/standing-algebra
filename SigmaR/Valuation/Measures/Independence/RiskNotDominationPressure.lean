import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces
import SigmaR.Valuation.Measures.RiskLoad_Definition
import SigmaR.Valuation.Measures.DominationPressure_Definition

/-!
###############################################################################
# Independence: Risk Not Domination Pressure
###############################################################################

Risk exposure does not license or imply domination pressure.

Risk load captures exposure to harm or uncertainty.
Domination pressure is a system-level diagnostic indicating
approach to structural collapse.

No default implication from risk exposure to domination
pressure is licensed.
###############################################################################
-/

namespace SigmaR

/--
No implication treating risk exposure as constituting
or licensing domination pressure is permitted.
-/
axiom risk_not_domination_pressure :
  ¬ (
    ∀ (a : Agent) (s : State),
      TreatedAsDominationPressureFromRiskLoad a s
  )

end SigmaR
