import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization

/-!
###############################################################################
# Standing Monotonicity Under Structural Admissibility
###############################################################################

Standing is the weighted, capacity-indexed valuation

  σv(s,i) = w₁ * CIA(s,i) - w₂ * deg(s,i) - w₃ * RiskLoad(s,i)
            + w₄ * ExitViable(s,i)

with w₁, w₂, w₃, w₄ ≥ 0.

Structurally admissible operations preserve:

  • CIA (non-decreasing)
  • dependency (non-increasing)
  • risk exposure (non-increasing)
  • exit viability (non-decreasing)

Therefore the weighted valuation does not decrease.

The combination above is arithmetic in an ordered commutative ring.  This
development is core Lean only — there is no Mathlib here — so the weighted
combination of the component measures is not available as a definition.  The
claim is therefore recorded at the tier-2 legitimacy layer, over the
state-indexed valuation `σv` of the valuation layer, with the component
monotonicities as its hypotheses.  A proof from components would need the
ordered-ring combination, which this library does not carry.
-/

namespace SigmaR

/--
Predicate: operation `F` never decreases any agent's standing,
at any state in which it applies.
-/
def StandingMonotone (F : Operation) : Prop :=
  ∀ (s : State) (i : Agent), σv i (apply F s) ≥ σv i s

/--
Tier‑2 legitimacy axiom (Standing Monotonicity):

Structurally admissible operations never decrease the state-indexed standing
valuation of any agent.
-/
axiom standing_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    σv i (apply F s) ≥ σv i s

end SigmaR
