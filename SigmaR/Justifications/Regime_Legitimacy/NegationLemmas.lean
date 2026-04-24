import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Negation Lemmas (Regime-Independent)
###############################################################################

This file collects all regime-independent negation lemmas.

Negation lemmas do NOT:
  • introduce regimes
  • rank regimes
  • authorize actions
  • select outcomes

They only express what must fail
when structural constraints fail.

All regimes inherit these consequences uniformly.
###############################################################################
-/

namespace SigmaR

/-- Generic constraint predicate over operations. -/
constant Constraint : Operation → Prop

/-- Generic regime condition predicate over operations. -/
constant RegimeCondition : Operation → Prop

/-- Generic accumulation predicate (e.g. risk, debt, drift). -/
constant Accumulates : Operation → Prop

/-- Generic repair availability predicate. -/
constant RepairAvailable : Operation → Prop

/-- Generic resolution availability predicate. -/
constant ResolutionAvailable : Operation → Prop

/-
-----------------------------------------------------------------------------
1. Constraint failure implies inadmissibility
-----------------------------------------------------------------------------
-/

/--
If a required structural constraint fails,
the operation is inadmissible.
-/
axiom ConstraintFailure_Inadmissible :
  ∀ F : Operation,
    ¬ Constraint F →
    ¬ Admissible F

/-
-----------------------------------------------------------------------------
2. Regime condition failure implies illegitimacy
-----------------------------------------------------------------------------
-/

/--
If an operation participates in a regime
but fails that regime’s condition,
it is illegitimate.
-/
axiom RegimeFailure_Illegitimate :
  ∀ F : Operation,
    ¬ RegimeCondition F →
    ¬ Legitimate F

/-
-----------------------------------------------------------------------------
3. Accumulation without repair forces illegitimacy
-----------------------------------------------------------------------------
-/

/--
Accumulation without an available repair path
is structurally illegitimate.
-/
axiom AccumulationWithoutRepair_Illegitimate :
  ∀ F : Operation,
    Accumulates F →
    ¬ RepairAvailable F →
    ¬ Legitimate F

/-
-----------------------------------------------------------------------------
4. No admissible resolution forces non-action
-----------------------------------------------------------------------------
-/

/--
If no admissible resolution is available,
the only permitted operation is identity.
-/
axiom NoResolution_ForcesIdentity :
  ∀ F : Operation,
    ¬ ResolutionAvailable F →
    F = IdentityOp

end SigmaR
