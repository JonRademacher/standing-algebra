import SigmaR.Justifications.Core_Legitimacy.STC5_Justification

/-!
###############################################################################
# Justification of Off‑Ramps and Correction
###############################################################################

Legitimate coercion must preserve a path back to autonomy.

From *On Relevance*:

  • External correction is justified only under validated harm.
  • Coercion must not create persistent structural domination.
  • Legitimate intervention must allow for termination or reversal.

Standing Algebra encodes this through:
  • Exit preservation,
  • Repair obligations,
  • Emergency termination constraints.

Any operation that forecloses the possibility of exit or correction
creates structural entrapment and increases domination pressure.

Therefore:

  Legitimate F → OffRampsAndCorrection F s

at every state s.
-/

namespace SigmaR

/--
Predicate: the operation preserves off‑ramps or corrective pathways
at the given state.

This captures that coercive intervention remains:
  • reversible,
  • terminable,
  • or repairable.
-/
constant OffRampsAndCorrection : Operation → State → Prop

/--
Tier‑2 legitimacy axiom:

If an operation is Legitimate, then at every state it must preserve
off‑ramps or correction pathways.
-/
axiom offramps_required_for_legitimacy :
  ∀ {F : Operation},
    Legitimate F →
      ∀ s : State,
        OffRampsAndCorrection F s

/--
Derived theorem:

Legitimacy implies preservation of off‑ramps or correction.
-/
theorem OffRampsAndCorrection_required_for_legitimacy
  {F : Operation}
  (hLeg : Legitimate F) :
  ∀ s : State,
    OffRampsAndCorrection F s :=
by
  exact offramps_required_for_legitimacy hLeg

end SigmaR
