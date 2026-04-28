import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Definition Neutrality
###############################################################################

Valuation definitions must be semantically neutral.

They must not encode moral judgments, policy decisions,
optimization goals, or normative classifications.
###############################################################################
-/

namespace SigmaR

/--
Primitive definitions must not enforce normative distinctions.

Any evaluative or policy-driven semantics must be introduced
in higher layers or explicit models.
-/
axiom definition_neutrality :
  ∀ (M : Agent → State → Nat),
    ¬ (∃ (a : Agent) (s : State),
         M a s = 0 ∨ M a s = 100)

end SigmaR
