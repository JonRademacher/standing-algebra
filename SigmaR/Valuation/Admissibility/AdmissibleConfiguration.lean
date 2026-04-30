import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Admissible Configuration
###############################################################################

This file defines admissibility of a complete valuation configuration,
consisting of measures, structure, and declared constraints.

It does NOT:
• assert truth of any configuration
• assert legitimacy or authority
• permit intervention or action
• impose semantic interpretation

It ONLY governs permission to reason with a configuration.
###############################################################################
-/

namespace SigmaR

/--
A valuation configuration is admissible if it is explicitly declared
and structurally coherent under the system's constraints.
-/
constant AdmissibleConfiguration : Prop

end SigmaR
