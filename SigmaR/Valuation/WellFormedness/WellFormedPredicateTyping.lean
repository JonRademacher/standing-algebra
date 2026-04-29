import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Predicate Typing
###############################################################################

Predicates must not be used as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
A predicate has propositional type, not numeric type.
-/
axiom wellformed_predicate_typing :
  ∀ (P : Agent → State → Prop),
    True

end SigmaR
