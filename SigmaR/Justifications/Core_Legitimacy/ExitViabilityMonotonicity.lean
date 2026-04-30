module SigmaR.Justifications.Core_Legitimacy.ExitViabilityMonotonicity

import SigmaR.Core.StandingValuation
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

variables
  (θ : Agent → ℝ)

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
begin
  intros F s i hAdm hExit,

  unfold ExitViable at *,

  have hDeg :
    deg_dom (apply F s) i ≤ deg_dom s i,
    from dominant_dependency_bounded hAdm,

  linarith
end

end SigmaR
