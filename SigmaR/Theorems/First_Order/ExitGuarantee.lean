import SigmaR.StandingAlgebra_RegimeStacked

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ
   Meta‑Theorem: Exit Guarantee
   =========================================================

   Statement:
   Any system satisfying the Standing Algebra core,
   base regimes, and first‑order compositions
   guarantees viable exit.

   Informally:
   For every agent, there exists some admissible
   exit operation that preserves minimum standing.

   This guarantee is unconditional at first order:
   exit may not be contingent on repair, emergency,
   risk, or epistemic agreement.

   This is a first‑order structural guarantee of Σᴿ.

   No proofs are provided at this stage.
   ========================================================= -/

/- -----------------
   Exit Guarantee
   ----------------- -/

axiom Exit_guarantee :
  ∀ (a : Agent),
    ∃ F : Operation,
      Exit F ∧
      MinStanding ≤ σ (apply F a)

end SigmaR
