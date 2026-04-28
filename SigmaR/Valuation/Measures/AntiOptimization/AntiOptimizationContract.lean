import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# AntiOptimization Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/AntiOptimization` layer in SigmaR.

It introduces no valuation measures, no dynamics, and no
behavioral axioms.

Its purpose is to explicitly prohibit optimization,
teleology, and instrumental reasoning from being implicitly
assumed in the valuation system.

This contract is binding for all files in this directory.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

The SigmaR valuation system is *not* an optimization framework.

Valuation measures are descriptive diagnostics, not objectives,
utilities, or targets of action.

No measure is assumed to be improved, maximized, optimized,
balanced, or traded off against another.
###############################################################################
-/

/-!
###############################################################################
## Prohibited Assumptions
###############################################################################

The AntiOptimization layer explicitly forbids the following
assumptions unless introduced by a separate, explicit layer:

• Existence of a global objective or goal
• Utility functions or welfare maximization
• Scalarization of multiple valuation dimensions
• Tradeoff or compensatory justification
• Ranking or selection of agents or states
• Progress or convergence guarantees
• Equilibrium or fixed-point assumptions
• Metric targeting or proxy optimization
• Endogenous or adaptive goal formation
• Self-referential or reflexive optimization

Any reasoning that depends on these assumptions
is invalid within SigmaR by default.
###############################################################################
-/

/-!
###############################################################################
## Relationship to Other Layers
###############################################################################

• Definitions specify *what* measures are.
• WellDefinedness specifies *when* they are admissible.
• Independence specifies *what cannot be inferred*.
• Monotonicity specifies *how measures may evolve*.
• AntiOptimization specifies *what measures must never be used for*.

AntiOptimization does not weaken other layers.
It prevents teleological or instrumental misuse of them.
###############################################################################
-/

/-!
###############################################################################
## Non-Goals
###############################################################################

The AntiOptimization layer intentionally does NOT:

• Define preferred outcomes
• Define policies or interventions
• Define optimal states
• Define equilibria or steady states
• Define rational choice or incentives
• Define success or failure criteria

Such concepts, if desired, must be introduced
in higher, explicitly normative layers.
###############################################################################
-/

/-!
###############################################################################
## Closure
###############################################################################

With this contract in place, any optimization, progress,
or goal-directed interpretation of SigmaR requires an
explicit, visible extension of the theory.

Silent optimization is impossible by construction.
###############################################################################
-/
