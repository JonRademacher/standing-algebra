import SigmaR_Core

open Nat
open SigmaR

namespace SigmaR

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

end SigmaR
