import SigmaR.Justifications.Core_Legitimacy.CIA_Justification

/-!
###############################################################################
# Justification of Perceptual Frame Agreement (PFA)
###############################################################################

In *On Relevance*, Perceptual Frame Agreement (PFA) is the primary empirical
basis for public warrant.

PFA is not testimony, belief, or assertion. It is the emergent phenomenon
of convergent perceptual coupling among agents operating under shared
conditions. It arises when multiple perceptual frames stabilize sufficiently
to support coordinated action, correction, and revision.

Key commitments from *On Relevance*:

  • PFA is not a metaphysical truth-maker, but the strongest publicly
    available warrant under corrigible access conditions.
  • Practices such as shared observation, agreed operations,
    instrumentation, and third-party replication aim at PFA.
  • Claims reproducible across perceptual frames under agreed operations
    function as practical truths until revised.
  • PFA is the default gate for empirical relevance and public standing.
  • Standing and legitimacy are scale-relative: a claim may satisfy a local
    PFA while failing at broader scopes.
  • Non-parochial evidence is evidence not controlled solely by the claimant;
    PFA is what delivers such evidence.
  • Autonomy is demonstrated, not asserted: it emerges structurally when
    transition criteria are satisfied within a PFA rather than by private
    testimony or subjective endorsement.

Because every regime (Exit, Remedy, Emergency, Risk, etc.) presupposes
validated harm and non-parochial evidence, PFA belongs at the Core level.
It is the evidential substrate upon which legitimacy itself is evaluated.
-/

namespace SigmaR

/-- Predicate: the relevant perceptual frames have converged
    under shared conditions at state `s`. -/
constant PFA : State → Prop

/-- Predicate: the evidence available at state `s` is non-parochial,
    i.e. not controlled solely by the claimant. -/
constant NonParochialEvidence : State → Prop

/--
Core evidential axiom:

Perceptual Frame Agreement implies the availability of non-parochial
evidence. Where frames have converged under shared operations, the
resulting evidence is publicly corrigible and not privately controlled.
-/
axiom pfa_implies_non_parochial :
  ∀ s : State,
    PFA s →
    NonParochialEvidence s

end SigmaR
