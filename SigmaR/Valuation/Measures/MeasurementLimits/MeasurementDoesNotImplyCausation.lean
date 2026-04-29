import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Does Not Imply Causation
###############################################################################

Observed correlations or measurements do not
establish causal relationships.
###############################################################################
-/

namespace SigmaR

/--
Measurement does not imply causation.
-/
axiom measurement_not_causation :
  ¬ (∃ (C : State → State → Prop),
        True)

end SigmaR
