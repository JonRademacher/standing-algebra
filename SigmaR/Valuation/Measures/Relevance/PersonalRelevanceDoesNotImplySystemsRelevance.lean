import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Personal Relevance Does Not Imply System Relevance
###############################################################################

Relevance sufficient for personal action does not
establish relevance for collective or system-level evaluation.
###############################################################################
-/

namespace SigmaR

/--
Personal relevance does not imply system relevance.
-/
axiom personal_not_system_relevance :
  ∀ (R : Agent → State → Prop),
    ¬ (∀ a s, R a s → True)

end SigmaR
