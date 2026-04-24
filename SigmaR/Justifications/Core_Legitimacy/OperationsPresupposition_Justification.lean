import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Operations Presupposition Justification
###############################################################################

This file makes explicit the semantic presuppositions
required for something to count as an Operation in Σᴿ.

This is NOT a legitimacy condition.
This is NOT a regime constraint.
This is NOT a normative filter.

It states only:

  • Operations are defined relative to the Σᴿ core structure.
  • Any transformation that does not respect this structure
    is not an operation of the theory at all.

This prevents "out-of-model" transformations
from being smuggled in as admissible or illegitimate acts.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` respects the core
structural semantics of Σᴿ.

This includes (at minimum):
  • agent domain preservation
  • standing well-definedness
  • degree well-definedness
  • typing correctness
-/
constant CoreSemanticPresupposition : Operation → Prop

/--
Operations presupposition axiom:

All operations of Σᴿ must satisfy the core
semantic presuppositions of the framework.

Failure is undefinedness, not illegitimacy.
-/
axiom OperationsPresupposeCore :
  ∀ F : Operation,
    CoreSemanticPresupposition F

/--
Derived theorem:

There are no "structure-violating" operations
inside Σᴿ.
-/
theorem AllOperationsPresupposeCore
  (F : Operation) :
  CoreSemanticPresupposition F :=
by
  exact OperationsPresupposeCore F

end SigmaR
