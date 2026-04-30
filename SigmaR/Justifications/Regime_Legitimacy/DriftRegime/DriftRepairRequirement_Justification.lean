module SigmaR.Justifications.Regime_Legitimacy.DriftRegime.DriftRepairRequirement_Justification

import SigmaR.Justifications.Regimes.RemedyRegime.RemedyRegime_Justification
import SigmaR.Justifications.Regimes.DriftRegime.DriftRegime_Justification

/-!
###############################################################################
# Drift Repair Requirement Justification
###############################################################################

Standing Algebra requires that accumulated fragility
be corrected by repair.

From Standing Algebra:

  • Drift accrues structural debt.
  • Structural debt cannot grow unbounded.
  • Repair is the only admissible mechanism
    for debt dissipation.

Therefore:

  Drift must terminate in repair.
###############################################################################
-/

namespace SigmaR

/--
Predicate: drift operation `D` requires
a repair operation `R` after accumulation.
-/
constant DriftRequiresRepair : Operation → Operation → Prop

/--
Tier-2 legitimacy axiom (Drift Repair Requirement):

Drift operations must admit a repair path
that dissipates accumulated debt.
-/
axiom drift_requires_repair :
  ∀ {D : Operation},
    DriftRegimeOp D →
    ∃ R : Operation,
      RepairRegimeOp R ∧ DriftRequiresRepair D R

/--
Derived theorem:

Drift terminates in repair.
-/
theorem DriftTerminatesInRepair
  {D : Operation}
  (hDrift : DriftRegimeOp D) :
  ∃ R : Operation,
    RepairRegimeOp R ∧ DriftRequiresRepair D R :=
by
  exact drift_requires_repair hDrift

end SigmaR
