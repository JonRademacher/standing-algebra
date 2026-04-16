import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Epistemic Non‑Authority
   =========================================================

   Statement:
   Epistemic inputs may inform action but may never
   confer authority, admissibility, or coercive power.

   Informally:
   Claims, evidence, risk assessments, models, and
   inferences may guide understanding, but they may
   not authorize actions that would otherwise be
   inadmissible or dominating.

   This theorem generalizes Risk Non‑Authorization
   to all epistemic sources.

   This is a first‑order semantic consequence of the
   Adapter + Risk compositions.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Epistemic Non‑Authority
   ----------------- -/

axiom Epistemic_non_authority :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    ¬ Admissible F

end SigmaR
