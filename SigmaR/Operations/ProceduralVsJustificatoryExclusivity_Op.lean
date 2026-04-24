import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Procedural vs Justificatory Exclusivity (Operations)
###############################################################################

This file distinguishes two kinds of exclusivity:

  • Procedural exclusivity: which procedures
    are used in an operation.
  • Justificatory exclusivity: which structural
    justification conditions apply.

In Σᴿ:
  • Multiple procedures may be used jointly.
  • No procedure may operate *as* the justification
    for another.
  • Justification conditions are non-interchangeable.

This prevents procedural laundering.
###############################################################################
-/

namespace SigmaR

/--
Procedural method predicates.
-/
constant UsesNegotiation      : Operation → Prop
constant UsesCooperation      : Operation → Prop
constant UsesCompromise       : Operation → Prop
constant UsesTragicAcceptance : Operation → Prop

/--
Justificatory predicates (structural obligations).
-/
constant NegotiationJustified : Operation → Prop
constant CooperationJustified : Operation → Prop
constant CompromiseJustified  : Operation → Prop
constant TragicJustified      : Operation → Prop

/--
Procedural non-substitution axiom:

Using one procedure does not satisfy
the justificatory requirements of another.
-/
axiom ProceduralNotJustificatory :
  (∀ F, UsesNegotiation F → ¬ CompromiseJustified F) ∧
  (∀ F, UsesCompromise F → ¬ NegotiationJustified F) ∧
  (∀ F, UsesCooperation F → ¬ CompromiseJustified F) ∧
  (∀ F, UsesTragicAcceptance F →
      ¬ NegotiationJustified F ∧
      ¬ CooperationJustified F ∧
      ¬ CompromiseJustified F)

/--
Derived theorem:

Procedures cannot masquerade as justifications.
-/
theorem NoProceduralMasquerade
  (F : Operation)
  (hN : UsesNegotiation F) :
  ¬ CompromiseJustified F :=
(ProceduralNotJustificatory).left F hN

end SigmaR
