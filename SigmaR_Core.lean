import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

noncomputable def Realize_S : Agent → Agent := SucRealizer

theorem realize_S_spec (a : Agent) : σ (Realize_S a) = Nat.succ (σ a) :=
  SucRealizer_spec a

theorem ALRP_standing_preservation
    (F : Operation) (a : Agent) (h : Admissible F) :
    σ a ≤ σ (apply F a) :=
  ALRP F a h

end SigmaR
