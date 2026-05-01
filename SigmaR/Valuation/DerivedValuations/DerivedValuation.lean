import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Derived Valuation
###############################################################################

This file introduces the abstract notion of a derived valuation.

A derived valuation represents a value computed from
structural facts, measures, and response semantics.

It does NOT:
• assert correctness
• assert legitimacy
• authorize action
• imply intervention

It is a valuation artifact only.
###############################################################################
-/

namespace SigmaR

/--
An abstract derived valuation.
-/
constant DerivedValuation : Type

end SigmaR
