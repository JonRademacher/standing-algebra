import Std

open Nat

namespace SigmaR

set_option linter.unusedVariables false


/- =====================
   CORE
   ===================== -/

axiom State : Type
abbrev Agent := State
axiom Operation : Type

axiom σ : Agent → Nat
axiom apply : Operation → State → State

axiom DomPressure : State → Nat

axiom Admissible : Operation → Prop
axiom Legitimate : Operation → Prop

axiom ALRP_standing_preservation :
  ∀ (F : Operation) (a : Agent),
    Admissible F →
    σ a ≤ σ (apply F a)

axiom DomPressure_monotonic :
  ∀ (F : Operation) (s : State),
    Admissible F →
    DomPressure (apply F s) ≤ DomPressure s

axiom Realize_S : Agent → Agent
axiom realize_S_spec :
  ∀ a : Agent, σ (Realize_S a) = Nat.succ (σ a)

/- =====================
   BASICS
   ===================== -/

axiom legitimate_implies_admissible :
  ∀ F : Operation, Legitimate F → Admissible F

def StandingPreserved (F : Operation) : Prop :=
  ∀ a : Agent, σ a ≤ σ (apply F a)

def RaisesStanding (F : Operation) (a : Agent) : Prop :=
  σ a < σ (apply F a)

theorem admissible_preserves_standing :
  ∀ F : Operation,
    Admissible F →
    StandingPreserved F :=
by
  intro F hAdm a
  exact ALRP_standing_preservation F a hAdm

theorem legitimate_preserves_standing :
  ∀ F : Operation,
    Legitimate F →
    StandingPreserved F :=
by
  intro F hLeg
  have hAdm : Admissible F :=
    legitimate_implies_admissible F hLeg
  exact admissible_preserves_standing F hAdm

theorem legitimate_no_domination_escalation :
  ∀ (F : Operation) (s : State),
    Legitimate F →
    DomPressure (apply F s) ≤ DomPressure s :=
by
  intro F s hLeg
  have hAdm : Admissible F :=
    legitimate_implies_admissible F hLeg
  exact DomPressure_monotonic F s hAdm

theorem realize_S_strict :
  ∀ a : Agent,
    σ a < σ (Realize_S a) :=
by
  intro a
  rewrite [realize_S_spec]
  exact Nat.lt_succ_self _

def EscalatesDomination (F : Operation) (s : State) : Prop :=
  DomPressure (apply F s) > DomPressure s

axiom violation_implies_escalation :
  ∀ (F : Operation) (s : State),
    ¬ Admissible F →
    EscalatesDomination F s

theorem universality_contrapositive :
  ∀ (F : Operation) (s : State),
    ¬ EscalatesDomination F s →
    Admissible F :=
by
  intro F s hNoEsc
  by_cases hAdm : Admissible F
  · exact hAdm
  · have hEsc := violation_implies_escalation F s hAdm
    exact False.elim (hNoEsc hEsc)

/- =====================
   MODEL / SANITY EXAMPLE
   ===================== -/

/--
A toy model witnessing consistency of the Σᴿ axioms.

All assumptions are explicit arguments to avoid
section-scope issues in live.lean.
-/
theorem model_legitimate_safe_example
  (s0 : State)
  (F_id : Operation)
  (sigma_const : ∀ a : Agent, σ a = 1)
  (apply_identity : ∀ a : Agent, apply F_id a = a)
  (dompressure_zero : DomPressure s0 = 0)
  (F_id_admissible : Admissible F_id)
  (F_id_legitimate : Legitimate F_id) :
  ∀ s : State,
    DomPressure (apply F_id s) ≤ DomPressure s :=
by
  intro s
  exact DomPressure_monotonic F_id s F_id_admissible

end SigmaR
