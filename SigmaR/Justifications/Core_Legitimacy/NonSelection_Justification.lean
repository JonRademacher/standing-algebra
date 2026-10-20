import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Justification of Non‑Selection
###############################################################################

Standing Algebra (Σᴿ) is a structural filter on transformations. It classifies
which transformations are admissible; it never ranks admissible transformations
against each other.

Σᴿ, *Theorem (Non‑Determinacy of Legitimate Options)*:

  If `F` and `G` are two distinct transformations such that `Legitimate F` and
  `Legitimate G` both hold, then Σᴿ does not — and structurally cannot —
  designate a preference between `F` and `G`.

Non‑selection is what keeps Σᴿ from collapsing into a utility function, a
policy selector, or a preference aggregator.
###############################################################################
-/

namespace SigmaR

/--
Preference over operations.

`Preferred F G` records that a selection procedure ranks `F` above `G`.
-/
constant Preferred : Operation → Operation → Prop

/--
Σᴿ does not select among legitimate options.

Two distinct legitimate operations are never ranked against each other by the
algebra itself.
-/
axiom non_selection :
  ∀ {F G : Operation},
    Legitimate F →
    Legitimate G →
    F ≠ G →
    ¬ Preferred F G

/--
Legitimate options are not ranked.

This theorem makes the non‑selection guarantee available to downstream layers
without re‑stating the axiom.
-/
theorem legitimate_options_not_ranked
  {F G : Operation}
  (hF : Legitimate F) (hG : Legitimate G) (hne : F ≠ G) :
  ¬ Preferred F G :=
non_selection hF hG hne

/--
Pluralism: distinct legitimate operations may coexist without a tie‑break.

The algebra admits at least the possibility of two distinct legitimate
operations, so non‑selection is not vacuous.
-/
theorem legitimate_options_may_coexist
  {F G : Operation}
  (hF : Legitimate F) (hG : Legitimate G) (hne : F ≠ G) :
  Legitimate F ∧ Legitimate G ∧ ¬ Preferred F G :=
⟨hF, hG, legitimate_options_not_ranked hF hG hne⟩

end SigmaR
