import SigmaR.StandingAlgebra_FormalCore

namespace SigmaR

/- =========================================================
   Standing Algebra Σᴿ — Adapter / Observation Regime
   =========================================================

   This regime formalizes the treatment of inputs as
   non-authoritative claims. Truth is not modeled.

   Adapters:
   - may produce claims,
   - may inform operations,
   - may not authorize admissibility,
   - may not alter standing.

   This file depends ONLY on the Formal Core.
   ========================================================= -/

/- -----------------
   Adapter Sorts
   ----------------- -/

axiom Adapter : Type
axiom Claim : Type
axiom Observation : Type

/- -----------------
   Adapter Functions
   ----------------- -/

-- Adapters observe agents and produce observations
axiom observe : Adapter → Agent → Observation

-- Observations are interpreted into claims
axiom interpret : Adapter → Observation → Claim

-- Operations may reference claims
axiom usesClaim : Operation → Claim → Prop

/- -----------------
   Claim Classification
   ----------------- -/

-- Claims are diagnostic evidence
axiom Evidence : Claim → Prop

-- Claims are never authoritative
axiom Authority : Claim → Prop

/- -----------------
   Core Adapter Invariants
   ----------------- -/

-- Evidence and authority are mutually exclusive
axiom Evidence_not_Authority :
  ∀ c : Claim, Evidence c → ¬ Authority c

-- Claims default to evidence
axiom Claim_defaults_to_Evidence :
  ∀ c : Claim, ¬ Authority c → Evidence c

/- -----------------
   Non-Authoritativeness
   ----------------- -/

-- Claims may not confer admissibility
axiom Claim_not_Admissible :
  ∀ (F : Operation) (c : Claim),
    usesClaim F c → ¬ Authority c

-- No operation becomes admissible due to claims
axiom Claim_cannot_authorize :
  ∀ (F : Operation) (c : Claim),
    usesClaim F c → ¬ (Authority c → Admissible F)

/- -----------------
   Standing Neutrality
   ----------------- -/

-- Adapters do not increase standing
axiom Adapter_no_standing_increase :
  ∀ (A : Adapter) (F : Operation) (a : Agent),
    usesClaim F (interpret A (observe A a)) →
    σ (apply F a) ≤ σ a

-- Adapters do not decrease standing
axiom Adapter_no_standing_decrease :
  ∀ (A : Adapter) (F : Operation) (a : Agent),
    usesClaim F (interpret A (observe A a)) →
    σ a ≤ σ (apply F a)

/- -----------------
   Symmetry of Observation
   ----------------- -/

-- Observations are agent-symmetric
axiom Observation_symmetry :
  ∀ (A : Adapter) (a₁ a₂ : Agent),
    observe A a₁ = observe A a₂

/- -----------------
   No Persistence of Leverage
   ----------------- -/

-- Claims cannot cause lasting standing change
axiom Claim_no_persistence :
  ∀ (F : Operation) (c : Claim) (a : Agent),
    usesClaim F c →
    σ (apply F a) = σ a

end SigmaR
