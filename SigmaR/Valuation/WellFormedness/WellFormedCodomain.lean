import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Codomain
###############################################################################

Valuation measures must have a codomain that is
structurally appropriate for valuation.

This file prevents arbitrary Nat-valued functions
from being treated as valuation measures.
###############################################################################
-/

namespace SigmaR

/--
Not every Nat-valued function is a valuation measure.

In particular, functions whose Nat output encodes
non-valuation structure (identifiers, encodings,
tags, or opaque codes) may not be treated as measures.
-/
axiom no_arbitrary_nat_codomain_measure :
  ¬ (
    ∀ (f : Agent → State → Nat),
      IsMeasure f
  )

end SigmaR
