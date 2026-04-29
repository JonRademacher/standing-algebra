import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Context Binding
###############################################################################

Valuation measures must be explicitly bound to an
agent–state context.

This file prevents floating, context-free valuation
expressions from being treated as measures.
###############################################################################
-/

namespace SigmaR

/--
No valuation measure may be treated as context-free.

All measures must be explicitly bound to an agent–state context.
-/
axiom no_context_free_measure :
  ¬ (
    ∀ (M : Agent → State → Nat),
      IsMeasure M → ¬ ContextBound M
  )

end SigmaR

