import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Core.StructuralInterfaces

/-!
###############################################################################
# WellFormedness Scope
###############################################################################

WellFormedness applies only to the internal structure
of valuation expressions.

It does not constrain interpretation, usage, or consequence.
###############################################################################
-/

namespace SigmaR

/--
Well-formedness does not constrain interpretation,
usage, or consequence.

Those concerns are governed by higher layers.
-/
axiom wellformedness_does_not_constrain_interpretation :
  ¬ (
    ∀ (M : Agent → State → Nat),
      WellFormed M →
      ConstrainsInterpretation M
  )

end SigmaR

