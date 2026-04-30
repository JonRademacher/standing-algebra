module SigmaR.Justifications.Regime_Legitimacy.RegimesPresupposeOperations_Justification

import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Regimes Presuppose Operations Justification
###############################################################################

This file makes explicit that regimes in Σᴿ
are predicates over operations, not generators
or authorizers of operations.

Regimes:
  • do not create operations
  • do not reinterpret operations
  • do not weaken operation presuppositions
  • do not override operational semantics

They only constrain operations that already exist
within the Σᴿ object theory.
###############################################################################
-/

namespace SigmaR

/--
Predicate: `R` is a regime predicate over operations.
-/
constant RegimePredicate : (Operation → Prop) → Prop

/--
Regime presupposition axiom:

Any regime applies only to operations that already
satisfy the operational presuppositions of Σᴿ.
-/
axiom RegimesPresupposeOperations :
  ∀ (R : Operation → Prop),
    RegimePredicate R →
    ∀ F : Operation,
      R F →
      CoreSemanticPresupposition F

/--
Derived theorem:

No regime can make a non-operation admissible.
-/
theorem RegimeCannotCreateOperations
  (R : Operation → Prop)
  (hR : RegimePredicate R)
  (F : Operation)
  (hRF : R F) :
  CoreSemanticPresupposition F :=
by
  exact RegimesPresupposeOperations R hR F hRF

end SigmaR
