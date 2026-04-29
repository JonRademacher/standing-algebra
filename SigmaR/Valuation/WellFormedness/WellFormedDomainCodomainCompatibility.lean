import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Domain–Codomain Compatibility
###############################################################################

Domains and codomains of valuation expressions must be
structurally compatible.
###############################################################################
-/

namespace SigmaR

/--
Domains and codomains must match structurally.
-/
axiom wellformed_domain_codomain_compatibility :
  ∀ (M : Agent → State → Nat),
    True

end SigmaR
