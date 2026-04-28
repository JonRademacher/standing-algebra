import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Relevance Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/Relevance` layer in SigmaR.

The Relevance layer concerns *warrants*:
conditions under which valuation information may be
considered relevant for an agent or decision context.

This layer introduces no optimization, no aggregation,
no policy, and no collective justification.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

Relevance in SigmaR is *agent-relative* and *context-bound*.

A warrant specifies that certain information may be
considered relevant for an agent, not that it must be
acted upon or optimized.
###############################################################################
-/

/-!
###############################################################################
## Structural Rules
###############################################################################

All relevance and warrant constructs in this directory:

• Are non-optimizing
• Are non-aggregative
• Are non-transferable across agents by default
• Do not imply obligation, maximization, or policy
• Do not permit collective justification
• Do not override Independence, Monotonicity, or AntiOptimization

Relevance constrains *attention*, not *outcome*.
###############################################################################
-/

/-!
###############################################################################
## Non-Goals
###############################################################################

The Relevance layer does NOT:

• Define decisions or actions
• Define preferences or utilities
• Define optimal outcomes
• Define collective welfare
• Define policy or governance
• Define causal influence

Those belong in higher, explicitly normative layers.
###############################################################################
-/
