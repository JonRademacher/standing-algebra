import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Exit Viability — Definition
###############################################################################

ExitViable a records whether agent a retains
a structurally meaningful ability to exit or refuse coordination.

Source alignment:
  • Standing Algebra: exit is a core nondomination safeguard.
  • On Relevance: collapse of exit marks coercion,
    not merely inconvenience.

Exit viability is structural and non-numeric.
###############################################################################
-/

namespace SigmaR

/--
ExitViable a means agent a retains meaningful exit options.
-/
constant ExitViable : Agent → Prop

/--
Exit viability is a decidable structural property.
-/
axiom ExitViable_decidable :
  ∀ a : Agent, Decidable (ExitViable a)

end SigmaR
