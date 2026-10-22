import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Transformability Progress Option
###############################################################################

This file introduces the notion of a transformability-progress
option.

A transformability-progress option represents the existence of
a path that would strictly increase effective transformability.

It is a structural possibility, not a preference.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.TransformabilityValuation

/--
TransformabilityProgressOption O means that O represents
a transformability-increasing option.
-/
axiom TransformabilityProgressOption : Type

end SigmaR.Valuation.DerivedValuations.TransformabilityValuation
