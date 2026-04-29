import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# WellFormedness Contract
###############################################################################

This file defines the governing principles of the
`Valuation/WellFormedness` layer in SigmaR.

WellFormedness concerns *structural admissibility only*.
It determines whether an object is syntactically and
structurally legal — not whether it is meaningful, true,
valid, admissible, or justified.

This contract is binding for all files in this directory.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

An object is well-formed if and only if:
• its types are coherent
• its arity is correct
• its domains and codomains match
• its scope is explicit
• it is structurally non-circular

WellFormedness is entirely non-semantic.
###############################################################################
-/

/-!
###############################################################################
## Non-Goals
###############################################################################

The WellFormedness layer does NOT:
• assert truth or correctness
• assert admissibility or legitimacy
• assert authority or obligation
• assert optimization or preference
• assert relevance or importance

Those belong in higher layers.
###############################################################################
-/
