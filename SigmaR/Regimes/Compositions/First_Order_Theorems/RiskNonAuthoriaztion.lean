import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Risk Non‑Authorization
   =========================================================

   Statement:
   Informational risk may not authorize admissibility
   or coercive action.

   Informally:
   The presence, magnitude, or persistence of risk
   does not confer permission to act in ways that
   would otherwise be inadmissible.

   Risk may inform diagnosis, but it may never
   authorize domination.

   This theorem is a first‑order semantic consequence
   of the Risk Regime and the Adapter + Risk composition.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Risk Non‑Authorization
   ----------------- -/

axiom Risk_non_authorization :
  ∀ (F : Operation) (a : Agent),
    RiskBearer F a →
    ¬ Admissible F

end SigmaR
