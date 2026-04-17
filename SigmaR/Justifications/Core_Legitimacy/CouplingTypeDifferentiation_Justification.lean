
---

```lean
/-!
###############################################################################
# Justification of Coupling Type Differentiation
###############################################################################

In *On Relevance*, structural coordination
is mediated through coupling types including:

  • interdependent coupling,
  • emergent coupling,
  • relational identity‑defining coupling,
  • compositional coupling.

Standing, legitimacy, autonomy,
and constraint arise structurally
via such coupling.

Accordingly:

  Different coupling types propagate
  autonomy‑impacting constraint differently.

Interdependent and emergent coupling:

  • allocate structural risk,
  • may persist without culpability,
  • and generate Independently Emergent Wrong (IEW).

Compositional coupling:

  • aggregates role‑structured constraint
    across systems.

Relational identity‑defining coupling:

  • stabilizes group continuity,
  • but does not independently
    confer public standing.

Failure modes include:

  • failed coupling,
  • decoupling collapse,
    disabling answerability
    and correction.

Misidentifying coupling type permits:

  • preservation of revisable relations,
  • while autonomy‑critical coupling persists,
  • producing Exit collapse
    and IEW stabilization
    under procedural legitimacy.

At the Core level we therefore require:

  Coupling types must be
  distinguished relative to their
  constraint‑propagation capacity.

This ensures that:

  • dominant coupling may be identified,
  • exit viability analysis is meaningful,
  • standing evaluation tracks
    autonomy impact,
  • and IEW‑generating coupling
    cannot be masked by
    identity or role relations.
-/

namespace SigmaR

/-- Predicate: coupling types at state `s`
    are differentiated by autonomy impact. -/
constant CouplingTyped : State → Prop

/--
Core legitimacy axiom:

Coupling must be evaluated
relative to constraint propagation.
-/
axiom coupling_requires_typing :
  ∀ s : State,
    CouplingTyped s

end SigmaR
