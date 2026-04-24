import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
import SigmaR.Justifications.Core_Legitimacy.ExitViabilityMonotonicity
import SigmaR.Justifications.Core_Legitimacy.BoundedDrift_Justification
import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification

import SigmaR.Justifications.Regimes.RiskRegime.RiskDiscountingProhibition_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskInheritance_Justification
import SigmaR.Justifications.Regimes.RiskRegime.RiskLoadMonotonicity_Justification

/-!
###############################################################################
# Σᴿ Legitimacy Interface (Operations-Level Contract)
###############################################################################

This file aggregates the core consequences of the Σᴿ legitimacy
justifications into a single operational interface.

It does not introduce new axioms.
It does not redefine legitimacy.

Instead, it exposes the *obligations* that any legitimate operation
must satisfy, making the legitimacy contract explicit and reusable
for downstream theorems.

This file exists to make the structure of Σᴿ legible to reviewers,
proof engineers, and downstream users.
###############################################################################
-/

namespace SigmaR

------------------------------------------------------------------------
-- Standing Preservation
------------------------------------------------------------------------

/-- Legitimate operations preserve standing (ALRP). -/
theorem legitimacy_preserves_standing
  {F : Operation} {s : State} (hLeg : Legitimate F) (a : Agent) :
  σ (apply F s) a ≥ σ s a :=
ALRP_required_for_legitimacy hLeg a

------------------------------------------------------------------------
-- Directed Repair Obligation
------------------------------------------------------------------------

/-- Legitimate operations are directionally reparative. -/
theorem legitimacy_requires_directed_repair
  {F : Operation} (hLeg : Legitimate F) :
  ∀ s : State,
    DirectedRepair F s :=
DirectedRepair_required_for_legitimacy hLeg

------------------------------------------------------------------------
-- Exit Viability
------------------------------------------------------------------------

/-- Legitimate operations preserve exit viability monotonically. -/
theorem legitimacy_preserves_exit_viability
  {F : Operation} (hLeg : Legitimate F) :
  ExitViabilityMonotone F :=
ExitViabilityMonotonicity_required hLeg

------------------------------------------------------------------------
-- Bounded Drift
------------------------------------------------------------------------

/-- Legitimate operations satisfy bounded drift under iteration. -/
theorem legitimacy_bounded_drift
  {F : Operation} (hLeg : Legitimate F) :
  BoundedDrift F :=
BoundedDrift_required_for_legitimacy hLeg

------------------------------------------------------------------------
-- Non-Reciprocal Power Prevention
------------------------------------------------------------------------

/-- Legitimate operations satisfy NRPP. -/
theorem legitimacy_satisfies_NRPP
  {F : Operation} (hLeg : Legitimate F) :
  NRPP F :=
NRPP_required_for_legitimacy hLeg

------------------------------------------------------------------------
-- Risk Obligations
------------------------------------------------------------------------

/-- Legitimate operations may not discount introduced risk. -/
theorem legitimacy_prohibits_risk_discounting
  {F : Operation} {s : State}
  (hLeg : Legitimate F)
  (hRisk : RiskRegimeOp F s)
  (hIntro : IntroducesRisk F s) :
  ¬ RiskDiscounted F s :=
RiskDiscountingProhibited hLeg s hRisk hIntro

------------------------------------------------------------------------
-- Domination Exclusion
------------------------------------------------------------------------

/-- Legitimate operations do not induce dominant coupling. -/
theorem legitimacy_excludes_dominant_coupling
  {F : Operation} (hLeg : Legitimate F) :
  ¬ DominantCoupling F :=
DominantCoupling_prohibited_for_legitimacy hLeg

end SigmaR
