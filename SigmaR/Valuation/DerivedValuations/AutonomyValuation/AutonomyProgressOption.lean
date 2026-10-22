import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Autonomy Progress Option
###############################################################################

This file introduces the notion of an autonomy-progress option.

An autonomy-progress option represents the existence of a
structural path that would strictly increase effective autonomy.

It is a structural possibility, not a preference.
###############################################################################
-/

namespace SigmaR.Valuation.DerivedValuations.AutonomyValuation

/--
AutonomyProgressOption O means that O represents
an autonomy-increasing option.
-/
axiom AutonomyProgressOption : Type

end SigmaR.Valuation.DerivedValuations.AutonomyValuation
