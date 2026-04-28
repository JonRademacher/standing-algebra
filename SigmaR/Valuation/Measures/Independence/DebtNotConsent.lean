import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.StructuralDebt_Definition
import SigmaR.Standing.ConsentState_Definition

/-!
###############################################################################
# Independence: Structural Debt Not Consent
###############################################################################

This file establishes that structural debt does not entail
the absence of consent.

Structural debt tracks unresolved asymmetry or obligation
within a system.
Consent is an agent-level act or expression.

Importing this file explicitly rejects any assumption that
structural debt negates or invalidates consent.
###############################################################################
-/

namespace SigmaR

/--
There is no general implication from structural debt
to the absence of consent.
Any relationship between these concepts must be introduced explicitly.
-/
axiom debt_not_consent :
  ¬ (∀ (a : Agent) (s : State),
       StructuralDebt a → ¬ ConsentState a s)

end SigmaR

/-!
## Interpretation

This prevents downstream users from assuming that:
- obligation invalidates agreement
- debt implies coercion by definition
- structural asymmetry negates consent

Consent may occur despite structural debt.
-/
