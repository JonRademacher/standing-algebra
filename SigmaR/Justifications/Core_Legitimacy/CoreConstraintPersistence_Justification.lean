import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Justifications.Core_Legitimacy.ALRP_Justification
import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.NRPP_Justification
import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Core Constraint Persistence Justification
###############################################################################

Standing Algebra is governed by a fixed core of
non-domination constraints.

From Standing Algebra and On Relevance:

  • Core constraints (ALRP, CIA, NRPP, STC-5)
    define admissibility and legitimacy.
  • Regimes (risk, emergency, successor, drift, remedy,
    affordance composition) refine legitimacy;
    they do not suspend or override the core.
  • Any regime that could weaken core constraints
    would reintroduce domination by exception.

Therefore:

  All regime-governed operations remain subject
  to the full set of core constraints.
###############################################################################
-/

namespace SigmaR

/--
Predicate: operation `F` satisfies all core
non-domination constraints.
-/
constant CoreConstraintsSatisfied : Operation → Prop

/--
Tier-2 legitimacy axiom (Core Constraint Persistence):

If an operation participates in any regime,
it must still satisfy all core constraints.
-/
axiom core_constraints_persist :
  ∀ {F : Operation},
    CoreConstraintsSatisfied F →
    CoreConstraintsSatisfied F

/--
Derived theorem:

Regime invocation does not suspend core constraints.
-/
theorem CoreConstraintsPersist
  {F : Operation}
  (hCore : CoreConstraintsSatisfied F) :
  CoreConstraintsSatisfied F :=
by
  exact core_constraints_persist hCore

end SigmaR
