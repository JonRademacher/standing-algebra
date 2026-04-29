import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Measurement Limits Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/MeasurementLimits` layer in SigmaR.

Measurement limits constrain what may be *observed* or *resolved*
about valuation measures. They do not affect existence,
well-definedness, independence, monotonicity, or relevance.

Measurement limits are epistemic and instrumental constraints,
not semantic or ontological ones.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

Measurement limits describe the unavoidable constraints on
observing, resolving, and diagnosing valuation measures.

They do NOT imply:
• non-existence
• invalidity
• error
• failure
• obligation
• optimization
###############################################################################
-/

/-!
###############################################################################
## Structural Rules
###############################################################################

All axioms in this directory:

• Apply only to observability, not existence
• Do not license inference, causation, or control
• Do not grant authority or legitimacy
• Do not introduce optimization or objectives
• Do not override Relevance, Independence, or AntiOptimization
###############################################################################
-/

/-!
###############################################################################
## Non-Goals
###############################################################################

The MeasurementLimits layer intentionally does NOT:
• introduce probability or statistics
• model belief or confidence
• define truth or correctness
• define decision procedures

Such concepts belong in models, not Measures.
###############################################################################
-/
