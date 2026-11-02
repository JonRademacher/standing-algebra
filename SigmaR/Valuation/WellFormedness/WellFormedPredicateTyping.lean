import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# Well-Formed Predicate Typing
###############################################################################

Predicates must not be used as valuation measures.

This file prevents propositional conditions from being
coerced or encoded as numeric valuation measures.
###############################################################################
-/

namespace SigmaR

-- The numeric encoding of a predicate below is non-computable, so the
-- classical decision procedure supplies its `Decidable` instance.
attribute [local instance] Classical.propDecidable

/--
Predicates may not be treated as valuation measures
via numeric encoding.
-/
axiom no_predicate_as_measure :
  ¬ (
    ∀ (P : Agent → State → Prop),
      IsMeasure (fun a s => if P a s then 1 else 0)
  )

end SigmaR
