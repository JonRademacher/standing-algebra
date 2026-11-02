import SigmaR.StandingAlgebra_RegimeStacked
import SigmaR.Compositions.First_Order_Compositions.EmergencyRemedy

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Emergency Resolution Obligation
   =========================================================

   Proven version.

   This theorem states that emergency conditions
   generate an obligation to resolve via remedy
   when remedy is possible.

   It is a direct consequence of the
   Emergency + Remedy first‑order composition.
   ========================================================= -/

/- -----------------
   Emergency Resolution Obligation
   ----------------- -/

theorem Emergency_resolution_obligation :
  ∀ (s : State),
    EmergentWrong s →
    (∃ R : Operation, Remedy R) →
    ∃ R : Operation,
      Remedy R ∧
      ¬ EmergentWrong (apply R s) :=
by
  intro s hEmergency _
  -- If every remedy left the state emergent‑wrong, emergencies would persist
  -- without repair, which the Emergency + Remedy composition forbids.
  apply Classical.byContradiction
  intro hNone
  apply Emergency_cannot_persist_without_remedy s hEmergency
  intro R hR
  exact Classical.byContradiction (fun hStill => hNone ⟨R, hR, hStill⟩)

end SigmaR
