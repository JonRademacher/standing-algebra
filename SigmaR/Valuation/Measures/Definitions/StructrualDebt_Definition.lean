import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Debt — Definition
###############################################################################

StructuralDebt is a diagnostic valuation measuring
accumulated unresolved structural asymmetry affecting an agent.

• It is descriptive and diagnostic.
• It is not normative, punitive, or authorizing.
• Any invariants or properties are introduced elsewhere.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
StructuralDebt a is the successor-native measure
of unresolved structural fragility affecting agent a.
-/
axiom StructuralDebt : Agent → Nat

end SigmaR.Valuation.Measures.Definitions
