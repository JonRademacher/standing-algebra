import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Risk Load — Definition
###############################################################################

RiskLoad measures the structural exposure borne by an agent.

Source alignment:
  • Standing Algebra: risk is inherited exposure,
    not likelihood, utility, or expected value.
  • On Relevance: risk grounds standing and
    justification, but does not itself authorize action.

RiskLoad is purely diagnostic and successor-native.
###############################################################################
-/

namespace SigmaR

/--
RiskLoad a is the successor-native measure
of structural risk exposure borne by agent a.
-/
constant RiskLoad : Agent → Nat

/--
Risk load is always well-defined and non-negative.
-/
axiom RiskLoad_nonneg :
  ∀ a : Agent, 0 ≤ RiskLoad a

end SigmaR
