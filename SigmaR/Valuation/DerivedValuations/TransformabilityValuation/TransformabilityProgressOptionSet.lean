import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.DerivedValuations.TransformabilityValuation.TransformabilityProgressOption

/-!
###############################################################################
# Transformability Progress Option Set
###############################################################################

This file introduces sets of transformability-progress options.

These sets define the structural boundary of available
transformability-increasing paths.

This is not selection.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityProgressOptionSet S means that S is a set
of transformability-progress options.
-/
axiom TransformabilityProgressOptionSet : Type

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
