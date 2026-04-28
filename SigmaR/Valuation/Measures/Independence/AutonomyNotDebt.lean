import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.AutonomyMeasure_Definition
import SigmaR.Valuation.Measures.StructuralDebt_Definition

/-!
###############################################################################
# Independence: Autonomy Not Structural Debt
###############################################################################

This file establishes that autonomy does not entail structural debt.

Loss of autonomy and accumulation of structural debt are distinct
phenomena. Either may occur without the other, and no implication
between them is assumed at the level of measures.

Importing this file explicitly rejects any default assumption that
autonomy loss implies debt.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from autonomy measures to structural debt.
Any relationship between these quantities must be introduced explicitly.
-/
axiom autonomy_not_debt :
  ¬ (∀ (a : Agent) (s : State),
       AutonomyMeasure a s → StructuralDebt a)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- reduced autonomy implies obligation
- constraint implies indebtedness
- social control can be justified as debt accounting

Such inferences must be made explicit if intended.
-/

