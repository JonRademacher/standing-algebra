import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Standing Non-Fungibility (Valuation Core)
###############################################################################

This file establishes that standing, exit viability,
risk, and debt are NOT fungible valuation quantities.

No combination of gains for one agent may compensate
for losses of standing or exit for another.

This is a valuation constraint only.
###############################################################################
-/

namespace SigmaR

/--
Standing valuation for an agent in a state.
-/
constant StandingValue : Agent → State → Nat

/--
Predicate: two agents' standing values are fungible.
(This predicate will be shown impossible.)
-/
constant FungibleStanding : Agent → Agent → State → Prop

/--
Non-fungibility axiom:

Standing is not exchangeable across agents.
-/
axiom StandingNonFungible :
  ∀ (i j : Agent) (s : State),
    i ≠ j →
    ¬ FungibleStanding i j s

/--
Derived theorem:
No cross-agent compensation of standing is possible.
-/
theorem NoStandingCompensation
  (i j : Agent) (s : State)
  (hij : i ≠ j) :
  ¬ FungibleStanding i j s :=
by
  exact StandingNonFungible i j s hij

end SigmaR
