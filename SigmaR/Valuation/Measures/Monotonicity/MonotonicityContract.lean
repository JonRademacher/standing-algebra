import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Monotonicity Contract
###############################################################################

This file defines the governing principles of the
`Valuation/Measures/Monotonicity` layer in SigmaR.

It introduces **no axioms about specific measures**.
Instead, it specifies how monotonicity axioms are to be
interpreted, scoped, and constrained.

This contract is binding for all files in this directory.
###############################################################################
-/

/-!
###############################################################################
## Core Meaning
###############################################################################

Monotonicity in SigmaR constrains **how values may evolve**
with respect to an abstract state ordering.

Monotonicity does NOT imply:
- improvement
- causation
- continuity
- permanence
- global applicability

It is a restriction on evolution, not a guarantee of outcome.
###############################################################################
-/

/-!
###############################################################################
## Structural Rules
###############################################################################

All monotonicity axioms in this directory:

1. Are **directional**, never symmetric.
2. Are **conditional**, never absolute.
3. Are scoped to an explicit state ordering.
4. Do not assert causation between distinct measures.
5. Do not imply continuity or smooth change.
6. Do not guarantee persistence of values.
7. Do not permit creation ex nihilo.
8. Do not override Independence axioms.

Violations of these rules invalidate the semantic guarantees
of the Monotonicity layer.
###############################################################################
-/

/-!
###############################################################################
## Relationship to Independence
###############################################################################

The Monotonicity layer constrains **change**.
The Independence layer constrains **inference**.

Monotonicity must never be used to reintroduce
implications blocked by Independence.
###############################################################################
-/

/-!
###############################################################################
## Non-Goals
###############################################################################

The Monotonicity layer intentionally does NOT:
- define time
- define rates of change
- define causality
- define equilibrium
- define convergence
- enforce improvement or decline

Such claims belong in explicit models, not axioms.
###############################################################################
-/
