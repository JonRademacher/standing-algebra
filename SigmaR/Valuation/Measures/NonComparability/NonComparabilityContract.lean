import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Non-Comparability Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/NonComparability` layer in SigmaR.

It introduces no valuation measures and no behavior.
It establishes when and how valuation measures are
considered fundamentally non-comparable.

This contract is binding for all files in this directory.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

Non-comparability in SigmaR means that certain valuation
dimensions admit **no ordering, ranking, dominance, or
scalar comparison** by default.

Non-comparability is stronger than non-optimization and
orthogonal to independence.

It asserts the *absence of a comparison relation*, not
the presence of equality or equivalence.
###############################################################################
-/

/-!
###############################################################################
## Prohibited Interpretations
###############################################################################

Non-comparability must NOT be interpreted as:

• Equivalence or sameness
• Lack of information
• Temporary uncertainty
• Failure of measurement
• Permission to aggregate
• Permission to optimize

Any attempt to compare non-comparable measures is invalid
unless an explicit, higher-layer rule is introduced.
###############################################################################
-/

/-!
###############################################################################
## Relationship to Other Layers
###############################################################################

• Independence blocks inference.
• Monotonicity constrains evolution.
• AntiOptimization blocks teleology.
• Equivalence permits explicit sameness.
• NonComparability blocks ordering itself.

NonComparability does not weaken any other layer.
###############################################################################
-/

/-!
###############################################################################
## Closure
###############################################################################

With this contract in place, any attempt to order, rank,
or dominate non-comparable measures requires an explicit,
visible extension of the theory.

Silent comparison is impossible by construction.
###############################################################################
-/
