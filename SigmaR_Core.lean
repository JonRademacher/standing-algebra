import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

abbrev State := Agent

axiom DomPressure : State → Nat

noncomputable def Realize_S : Agent → Agent := SucRealizer

theorem realize_S_spec (a : Agent) : σ (Realize_S a) = Nat.succ (σ a) :=
  SucRealizer_spec a

theorem ALRP_standing_preservation
    (F : Operation) (a : Agent) (h : Admissible F) :
    σ a ≤ σ (apply F a) :=
  ALRP F a h

axiom DomPressure_monotonic :
  ∀ (F : Operation) (s : State),
    Admissible F → DomPressure (apply F s) ≤ DomPressure s

end SigmaR
