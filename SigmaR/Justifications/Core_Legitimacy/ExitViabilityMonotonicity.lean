import Mathlib.Data.Real.Basic
import SigmaR_Core
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization

/-!
###############################################################################
# Exit Viability Monotonicity Under Structural Admissibility
###############################################################################

Exit viability is defined as:

  ExitViableWithin(s,i)
    ↔
  dominantDependency(i,s) ≤ exitThreshold(i)

where:

  dominantDependency = dominant coupling dependency
  exitThreshold      = agent‑specific exit threshold.

Structurally admissible operations
do not increase dominant dependency.

Therefore:

  exit viability is preserved
  under structurally admissible operations.

Both quantities are read as signed integers, so the comparison and its
transitivity are core-Lean arithmetic (`omega`) rather than a Mathlib order on
a real-valued carrier.
-/

namespace SigmaR

/-- Dominant coupling dependency of agent `i` at state `s`. -/
axiom dominantDependency : Agent → State → Int

/-- Agent‑specific exit threshold. -/
axiom exitThreshold : Agent → Int

/-- Dominant dependency of an agent in a state. -/
axiom deg_dom : State → Agent → ℝ

/--
Exit viability definition
(dominant dependency stays within the agent's exit threshold).
-/
def ExitViableWithin (s : State) (i : Agent) : Prop :=
  dominantDependency i s ≤ exitThreshold i

/--
Tier‑2 legitimacy axiom:

Dominant dependency
is not increased by structurally admissible operations.
-/
axiom dominant_dependency_bounded :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    dominantDependency i (apply F s) ≤ dominantDependency i s

/--
Exit viability is preserved
under structurally admissible operations.
-/
theorem exit_viability_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    ExitViableWithin s i →
    ExitViableWithin (apply F s) i :=
by
  intro F s i hAdm hExit
  unfold ExitViableWithin at *
  have hDeg : dominantDependency i (apply F s) ≤ dominantDependency i s :=
    dominant_dependency_bounded hAdm
  omega

/--
Predicate: operation `F` preserves exit viability
wherever it is available.
-/
def ExitViabilityMonotone (F : Operation) : Prop :=
  ∀ (s : State) (i : Agent),
    ExitViableWithin s i →
    ExitViableWithin (apply F s) i

/--
Legitimacy implies exit viability monotonicity.
-/
theorem ExitViabilityMonotonicity_required
  {F : Operation}
  (hLeg : Legitimate F) :
  ExitViabilityMonotone F :=
by
  intro s i hExit
  exact exit_viability_monotone (legitimacy_characterization.1 hLeg) hExit

end SigmaR
