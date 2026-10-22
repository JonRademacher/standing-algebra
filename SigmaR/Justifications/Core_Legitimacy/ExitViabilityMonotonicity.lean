import Mathlib.Data.Real.Basic
import SigmaR_Core
import SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization

/-!
###############################################################################
# Exit Viability Monotonicity Under Structural Admissibility
###############################################################################

Exit viability is defined as:

  ExitViable(s,i)
    ↔
  deg_dom(s,i) ≤ θ(i)

where:

  deg_dom = dominant coupling dependency
  θ(i)    = agent‑specific exit threshold.

Structurally admissible operations
do not increase dominant dependency.

Therefore:

  exit viability is preserved
  under structurally admissible operations.
-/

namespace SigmaR

variable
  (θ : Agent → ℝ)

/-- Dominant dependency of an agent in a state. -/
axiom deg_dom : State → Agent → ℝ

/--
Exit viability definition.
-/
def ExitViable (s : State) (i : Agent) : Prop :=
  deg_dom s i ≤ θ i

/--
Dominant dependency
is monotone under admissibility.
-/
axiom dominant_dependency_bounded :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    deg_dom (apply F s) i ≤ deg_dom s i

/--
Exit viability is preserved
under structurally admissible operations.
-/
theorem exit_viability_monotone :
  ∀ {F : Operation} {s : State} {i : Agent},
    StructurallyAdmissible F s →
    ExitViable θ s i →
    ExitViable θ (apply F s) i :=
by
  intro F s i hAdm hExit
  unfold ExitViable at *
  exact le_trans (dominant_dependency_bounded hAdm) hExit

/-- Exit viability is preserved at every state by a legitimate operation. -/
def ExitViabilityMonotone (F : Operation) : Prop :=
  ∀ (θ : Agent → ℝ) (s : State) (i : Agent),
    ExitViable θ s i → ExitViable θ (apply F s) i

/-- Legitimacy provides structural admissibility, hence exit monotonicity. -/
theorem ExitViabilityMonotonicity_required
  {F : Operation} (hLeg : Legitimate F) :
  ExitViabilityMonotone F := by
  intro θ s i hExit
  exact exit_viability_monotone θ
    ((legitimacy_characterization (F := F) (s := s)).mp hLeg) hExit

end SigmaR
