import SigmaR.Justifications.Regimes.SuccessorRegime.SuccessorRegime_Justification
import SigmaR.Justifications.Regimes.ExitRegime.ExitRegime_Justification
import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification

/-!
###############################################################################
# Successor Continuation Justification
###############################################################################

Standing Algebra treats successor change as discrete
and standing-relevant.

From Standing Algebra and On Relevance:

  • A successor operation may be legitimate at a given state
    yet illegitimate if it structurally dead-ends the system.
  • Successor change must not force future exit collapse,
    repair foreclosure, or domination.
  • Legitimacy therefore requires the existence
    of at least one admissible continuation.

This does NOT require progress, convergence,
or inevitability — only non-dead-ending.

Therefore:

  Legitimate successor operations must admit
  legitimate continuation paths.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `G` is a legitimate continuation
of operation `F` at state `s`.
-/
constant LegitimateContinuation : Operation → Operation → State → Prop

/--
Tier-2 legitimacy axiom (Successor Continuation):

If a successor operation is legitimate,
then there exists at least one legitimate continuation
that preserves legitimacy conditions.

No successor may structurally dead-end the system.
-/
axiom successor_continuation_required :
  ∀ {F : Operation},
    SuccessorRegimeOp F →
    ∀ s : State,
      ∃ G : Operation,
        LegitimateContinuation F G s

/--
Derived theorem:

Legitimate successor operations admit continuation.
-/
theorem SuccessorHasContinuation
  {F : Operation}
  (hSucc : SuccessorRegimeOp F) :
  ∀ s : State,
    ∃ G : Operation,
      LegitimateContinuation F G s :=
by
  intro s
  exact successor_continuation_required hSucc s

end SigmaR
