import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed State Ordering
###############################################################################

This file defines structural well-formedness requirements for the
state ordering relation used throughout SigmaR.

It does NOT:
• assert that any ordering exists
• assert reflexivity, transitivity, or totality
• interpret the ordering as time, causation, or progress

It ONLY constrains how a state ordering may be *used* if introduced.
###############################################################################
-/

namespace SigmaR

/--
A state ordering relation is well-formed if it is explicitly declared
and consistently referenced within a valuation or reasoning context.
-/
constant WellFormedStateOrdering :
  (State → State → Prop) → Prop

/--
A valuation context that relies on a state ordering must explicitly
bind that ordering; no implicit or default ordering is permitted.
-/
constant StateOrderingContextBound :
  (State → State → Prop) → Prop

/--
A state ordering must not be implicitly interpreted as temporal,
causal, or normative without explicit declaration.
-/
constant StateOrderingNonInterpretive :
  (State → State → Prop) → Prop

end SigmaR
