import SigmaR.StandingAlgebra_FormalCore

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
WellFormedness is scoped to structural legality only.
-/
axiom wellformedness_is_structural :
  True

end SigmaR
