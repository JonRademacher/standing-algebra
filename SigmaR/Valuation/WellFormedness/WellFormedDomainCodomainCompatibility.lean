import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Domain–Codomain Compatibility
###############################################################################

Domains and codomains of valuation expressions must be
structurally compatible.

This file prevents illicit chaining or composition of
valuation measures based solely on superficial type alignment.
###############################################################################
-/

namespace SigmaR

/--
There is no general rule that the domain–codomain structure
of valuation measures is compatible.

Compatibility must be established explicitly elsewhere.
-/
axiom no_implicit_domain_codomain_compatibility :
  ¬ (
    ∀ (M₁ M₂ : Agent → State → Nat),
      IsMeasure M₁ →
      IsMeasure M₂ →
      CompatibleDomainCodomain M₁ M₂
  )

end SigmaR

