import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Affordance Composition Regime
   =========================================================

   This regime formalizes non-dominating resolution of
   multi-agent conflict by reshaping the action space.

   Conflict is not object-based; it is interference in
   affordance space.

   Lawful resolutions:
     (1) Downward restriction (remove affordances)
     (2) Symmetric reshaping (diversify contexts)

   No priority, arbitration, or optimization is introduced.
   ========================================================= -/

/- -----------------
   Affordance Structure
   ----------------- -/

axiom Affordance : Type
axiom Context : Type

-- An agent can exercise an affordance within a context
axiom Enables : Context → Affordance → Agent → Prop

-- Two affordances are incompatible within a context
axiom Incompatible : Context → Affordance → Affordance → Prop

-- Contexts that are admissible for interaction
axiom ContextAdmissible : Context → Prop

/- -----------------
   Conflict Definition
   ----------------- -/

-- Conflict exists when two distinct agents can exercise
-- incompatible affordances within an admissible context
def Conflict : Prop :=
  ∃ (c : Context) (a₁ a₂ : Affordance) (i₁ i₂ : Agent),
    ContextAdmissible c ∧
    Enables c a₁ i₁ ∧
    Enables c a₂ i₂ ∧
    Incompatible c a₁ a₂ ∧
    i₁ ≠ i₂

/- -----------------
   Space Reshaping Operations
   ----------------- -/

-- Operations that reshape the affordance space
axiom Reshape : Operation → Prop

-- Reshaping operations must be admissible
axiom Reshape_admissible :
  ∀ F : Operation, Reshape F → Admissible F

-- Reshaping preserves standing (no agent gains or loses)
axiom Reshape_preserves_standing :
  ∀ (F : Operation) (i : Agent),
    Reshape F →
    σ (apply F i) = σ i

/- -----------------
   Lawful Conflict Resolution
   ----------------- -/

-- Downward ratcheting:
-- reshaping may remove affordances to eliminate conflict
axiom DownwardRestriction :
  ∀ F : Operation,
    Reshape F →
    Conflict →
    ∀ c : Context, ContextAdmissible c

-- Symmetric reshaping:
-- reshaping may introduce distinct contexts so that
-- agents no longer collide in affordance use
axiom SymmetricDiversification :
  ∀ F : Operation,
    Reshape F →
    Conflict →
    ∀ (a : Affordance) (i₁ i₂ : Agent),
      ∃ (c₁ c₂ : Context),
        ContextAdmissible c₁ ∧
        ContextAdmissible c₂ ∧
        Enables c₁ a i₁ ∧
        Enables c₂ a i₂ ∧
        c₁ ≠ c₂

/- -----------------
   Non-Domination Guarantees
   ----------------- -/

-- No reshaping operation privileges any agent
axiom Reshape_no_privilege :
  ∀ (F : Operation) (i₁ i₂ : Agent),
    Reshape F →
    σ (apply F i₁) = σ (apply F i₂)

-- Conflict resolution must not foreclose exit
-- (Exit regime will refine this further)
axiom Conflict_preserves_exit :
  Conflict →
  ∃ F : Operation, Admissible F

end SigmaR
