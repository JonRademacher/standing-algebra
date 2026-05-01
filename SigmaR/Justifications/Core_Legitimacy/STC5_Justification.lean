import SigmaR.StandingAlgebra_RegimeStacked

/-!
###############################################################################
# Justification of STC‑5 (Standing‑to‑Coerce Legitimacy Gates)
###############################################################################

Standing to Coerce Test (STC‑5) from *On Relevance*:

Five necessary conditions for legitimate coercion:

  (1) Risk inheritance & validation
  (2) Non‑parochial evidence
  (3) NRPP fit
  (4) Alternatives considered
  (5) Off‑ramps and correction

Failure of any gate introduces domination pressure and therefore
invalidates legitimacy.

This file formalizes:

  Legitimate F → STC5_valid F

showing STC‑5 is a necessary condition for legitimacy.
-/

namespace SigmaR

------------------------------------------------------------------------
-- Abstract STC‑5 Gate Predicates
------------------------------------------------------------------------

/-- Gate 1: Risk inheritance & validation -/
constant RiskInheritanceValidated :
  Operation → State → Prop

/-- Gate 2: Non‑parochial evidence -/
constant NonParochialEvidence :
  Operation → State → Prop

/-- Gate 3: NRPP fit -/
constant NRPP_Fit :
  Operation → State → Prop

/-- Gate 4: Alternatives considered -/
constant AlternativesConsidered :
  Operation → State → Prop

/-- Gate 5: Off‑ramps and correction -/
constant OffRampsAndCorrection :
  Operation → State → Prop

------------------------------------------------------------------------
-- Combined STC‑5 Validity Predicate
------------------------------------------------------------------------

def STC5_valid (F : Operation) : Prop :=
  (∀ s : State, RiskInheritanceValidated F s) ∧
  (∀ s : State, NonParochialEvidence F s) ∧
  (∀ s : State, NRPP_Fit F s) ∧
  (∀ s : State, AlternativesConsidered F s) ∧
  (∀ s : State, OffRampsAndCorrection F s)

------------------------------------------------------------------------
-- Legitimacy implies each STC‑5 gate
-- (Operational legitimacy constraints from On Relevance)
------------------------------------------------------------------------

axiom legit_implies_risk_inheritance :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      RiskInheritanceValidated F s

axiom legit_implies_nonparochial :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      NonParochialEvidence F s

axiom legit_implies_nrpp :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      NRPP_Fit F s

axiom legit_implies_alternatives :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      AlternativesConsidered F s

axiom legit_implies_offramps :
  ∀ {F : Operation},
    Legitimate F →
    ∀ s : State,
      OffRampsAndCorrection F s

------------------------------------------------------------------------
-- STC‑5 required for legitimacy
------------------------------------------------------------------------

theorem STC5_required_for_legitimacy
  {F : Operation}
  (hLegit : Legitimate F) :
  STC5_valid F :=
by
  constructor
  · intro s
    exact legit_implies_risk_inheritance hLegit s
  constructor
  · intro s
    exact legit_implies_nonparochial hLegit s
  constructor
  · intro s
    exact legit_implies_nrpp hLegit s
  constructor
  · intro s
    exact legit_implies_alternatives hLegit s
  · intro s
    exact legit_implies_offramps hLegit s

end SigmaR
