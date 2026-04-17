/-!
###############################################################################
# Justification of Coupling Exhaustiveness
###############################################################################

Standing Algebra requires that all structural dependencies
between agents be classifiable under known coupling types.

From Σᴿ:

  • RiskLoad tracks autonomy‑relevant burden.
  • StructuralDebt accumulates under
    autonomy‑reducing coupling.
  • Exit viability depends upon identifying
    dominant dependency relations.

However:

  Dependencies that are not represented
  within the coupling domain structure (CDS)
  cannot be:

    • tracked by RiskLoad,
    • counted toward StructuralDebt,
    • or evaluated for Exit viability.

Such unmodeled dependencies may:

  • persist under legitimate intervention,
  • alter CIA‑indexed autonomy,
  • or generate IEW

while preserving procedural legitimacy.

This constitutes a legitimacy failure
arising from dependency invisibility.

At the Core level we therefore require:

  Any structural dependency
  affecting autonomy or standing
  must be classifiable
  under known coupling types.

This ensures that:

  • domination channels are representable,
  • RiskLoad remains complete,
  • StructuralDebt remains detectable,
  • and IEW cannot arise from
    unmodeled coupling.
-/

namespace SigmaR

/-- Predicate: all autonomy‑relevant dependencies
    at state `s` are classifiable
    under known coupling types. -/
constant CouplingExhaustive : State → Prop

/--
Core legitimacy axiom:

If PFA‑validated intervention occurs,
then autonomy‑relevant coupling
must be exhaustively represented.
-/
axiom intervention_requires_coupling_exhaustiveness :
  ∀ s : State,
    CouplingExhaustive s

end SigmaR
