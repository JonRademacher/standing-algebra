module SigmaR.Justifications.Core_Legitimacy.Agency_Justification

import SigmaR.StandingAlgebra_RegimeStacked

/-!
###############################################################################
# Justification of Agency from Abstraction
###############################################################################

In both *On Relevance* and the Standing Algebra (Σᴿ) framework, agency is not
treated as a primitive but as emerging from the cognitive capacity for
abstraction.

Abstraction is the capacity to:
  • generalize across contexts,
  • decouple stimuli from immediate perception,
  • form temporally extended goals,
  • model possible outcomes.

Without abstraction, an individual cannot coherently constitute ends,
evaluate alternatives, or engage in self-authorship. Therefore, the
capacity for abstraction provides the structural basis for agency.

This file formalizes the justification:

  AbstractionCapable a → Agentic a

grounding agency in abstraction as a necessary substrate for later
justifications of autonomy and capacity-indexed autonomy (CIA).
-/

namespace SigmaR

/-- Predicate: the agent possesses the capacity for abstraction. -/
constant AbstractionCapable : Agent → Prop

/-- Predicate: the agent is agentic (has a locus of will). -/
constant Agentic : Agent → Prop

/--
Philosophical justification for agency:

The capacity for abstraction suffices to ground agency.
-/
axiom abstraction_implies_agency :
  ∀ {a : Agent},
    AbstractionCapable a →
    Agentic a

/--
Derived theorem:

Any abstraction-capable agent is agentic.
-/
theorem Agency_from_abstraction
  {a : Agent}
  (h : AbstractionCapable a) :
  Agentic a :=
by
  exact abstraction_implies_agency h

end SigmaR
