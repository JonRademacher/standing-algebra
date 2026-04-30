import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Inference
###############################################################################

This file defines admissibility of inference patterns
within valuation reasoning.

It does NOT:
• introduce new inference rules
• override Independence constraints
• imply causation
• assert semantic conclusions

It ONLY governs permission to apply existing inference.
###############################################################################
-/

namespace SigmaR

/--
An inference pattern is admissible under the system's
declared constraints.
-/
constant AdmissibleInference : Prop

end SigmaR
