import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Equivalence Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/Equivalence` layer in SigmaR.

It introduces no equivalence claims.
Instead, it specifies how equivalence must be interpreted,
scoped, and constrained when it is explicitly declared.

This contract is binding for all files in this directory.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

Equivalence in SigmaR is:

• Explicit
• Contextual
• Non-inferential
• Non-substitutive
• Non-transitive by default
• Revocable

Equivalence is descriptive sameness under stated conditions,
not identity, inference, or operational interchangeability.
###############################################################################
-/

/-!
###############################################################################
## Prohibited Interpretations
###############################################################################

Equivalence must NOT be interpreted as:

• Definitional equality
• Substitution permission
• Inferential transfer
• Comparability or ordering
• Aggregation or optimization
• Global or permanent sameness

Any reasoning that relies on these interpretations
is invalid by default.
###############################################################################
-/

/-!
###############################################################################
## Relationship to Other Layers
###############################################################################

• Definitions specify what measures are.
• WellDefinedness specifies when they are admissible.
• Independence specifies what cannot be inferred.
• Monotonicity specifies how measures may evolve.
• AntiOptimization specifies what measures must not be used for.
• Equivalence specifies when sameness is explicitly declared,
  and what that sameness does NOT allow.

Equivalence does not weaken any other layer.
###############################################################################
-/

/-!
###############################################################################
## Closure
###############################################################################

With this contract in place, any use of equivalence
beyond descriptive, scoped sameness requires
explicit, visible extension of the theory.

Silent or global equivalence is impossible by construction.
###############################################################################
-/
