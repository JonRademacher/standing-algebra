import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   First‑Order Theorem: Structural Goodhart Exclusion
   =========================================================

   Statement:
   Proxy optimization may not undermine true standing.

   Informally:
   No admissible operation may improve a proxy,
   metric, or epistemic signal while reducing
   an agent’s standing.

   This theorem excludes Goodhart‑style failure
   at the structural level, not the statistical one.

   It ensures that proxy improvement cannot
   authorize harm or domination.

   This is a first‑order semantic consequence of
   the Adapter + Risk compositions and ALRP.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Structural Goodhart Exclusion
   ----------------- -/

axiom Structural_Goodhart_exclusion :
  ∀ (F : Operation) (a : Agent),
    (∃ c : Claim, usesClaim F c) →
    σ (apply F a) ≥ σ a

end SigmaR
