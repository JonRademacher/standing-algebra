/-!
###############################################################################
# Standing Valuation Layer
###############################################################################

Standing at this layer is treated as a scalar valuation relative to state.

This module does **not** introduce optimization, aggregation, or preference.
It only certifies that standing admits order-comparison across states, which is
the minimum structure required for proportional constraint, risk inheritance,
and restorative repair reasoning.

All higher commitments belong to later layers.
-/

namespace SigmaR

/-- Primitive sorts, assumed defined elsewhere in the core. -/
constant Agent : Type
constant State : Type

/-- Standing valuation for agent `i` at state `s`.  
    Interpreted as autonomy-relevant standing. -/
constant σ : Agent → State → ℝ

/--
`ValLe i s₁ s₂` means:
the standing of agent `i` at state `s₁`
is **no greater than**
the standing at state `s₂`.

This is an order relation only.
No aggregation or maximization is implied.
-/
def ValLe (i : Agent) (s₁ s₂ : State) : Prop :=
  σ i s₁ ≤ σ i s₂

/--
Standing valuation is reflexive:
an agent’s standing at a state
is always comparable to itself.
-/
theorem ValLe_refl (i : Agent) (s : State) :
  ValLe i s s :=
by
  unfold ValLe
  exact le_rfl

/--
Standing valuation is transitive:
if standing does not increase from `s₁` to `s₂`,
and does not increase from `s₂` to `s₃`,
then it does not increase from `s₁` to `s₃`.

This is the core structural fact that enables
proportionality without aggregation.
-/
theorem ValLe_trans
  (i : Agent)
  (s₁ s₂ s₃ : State) :
  ValLe i s₁ s₂ →
  ValLe i s₂ s₃ →
  ValLe i s₁ s₃ :=
by
  unfold ValLe
  intro h₁ h₂
  exact le_trans h₁ h₂

/--
Standing valuation induces a preorder over states
for each agent.

Antisymmetry is *intentionally not assumed* here,
since later layers may permit repair, restoration,
or non-strict preservation under equivalence.
-/
theorem ValLe_preorder (i : Agent) :
  Preorder State :=
{ le := ValLe i
  le_refl := ValLe_refl i
  le_trans := ValLe_trans i }

end SigmaR
