import SigmaR.StandingAlgebra_FormalCore

-- Base regimes
import SigmaR.Regimes.StandingAlgebra_AdapterRegime
import SigmaR.Regimes.StandingAlgebra_AffordanceCompositionRegime
import SigmaR.Regimes.StandingAlgebra_DriftRegime
import SigmaR.Regimes.StandingAlgebra_EmergencyRegime
import SigmaR.Regimes.StandingAlgebra_ExitRegime
import SigmaR.Regimes.StandingAlgebra_RemedyRegime
import SigmaR.Regimes.StandingAlgebra_RiskRegime
import SigmaR.Regimes.StandingAlgebra_SuccessorRegime

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Regime Stack
   =========================================================

   This file stacks the Formal Core with all base regimes.

   It introduces:
   - no new axioms,
   - no new definitions,
   - no obligations,
   - no theorems.

   Its purpose is to certify that all regimes coexist
   as conservative extensions of the core.

   All dependency requirements and obligations are
   deferred to composition files.
   ========================================================= -/

end SigmaR
