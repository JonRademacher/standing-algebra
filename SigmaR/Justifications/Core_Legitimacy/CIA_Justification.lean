import SigmaR.Justifications.Core_Legitimacy.Autonomy_Justification

/-!
###############################################################################
# Justification of Capacity‑Indexed Autonomy (CIA)
###############################################################################

In *Standing Algebra* and *On Relevance*, autonomy is grounded in agency and the
internalization of validated perceptual frames across time. However, the force
of autonomy is modulated by the agent’s capacity to exercise that agency.

Autonomy may exist in principle while being impaired in practice. Capacity
indexes the potency of autonomy: when capacity is sufficient, autonomy is
operative rather than merely latent.

This file introduces Capacity‑Indexed Autonomy (CIA) as the condition under
which an autonomous agent possesses the practical ability to realize her
self‑authorship.
-/

namespace SigmaR

/-- Predicate: the agent has sufficient capacity to exercise autonomy.
    Capacity may be cognitive, physical, situational, or social; its internal
    structure is left open for later refinement. -/
constant Capacity : Agent → Prop

/-- Predicate: the agent’s autonomy is indexed by sufficient capacity (CIA).
    CIA status reflects that autonomy is not merely possessed but enactable. -/
constant CIA_Autonomous : Agent → Prop

/--
Tier‑2 legitimacy axiom for CIA:

If an agent is Autonomous and has sufficient Capacity, then she enjoys
Capacity‑Indexed Autonomy.
-/
axiom cia_from_aut_and_cap :
  ∀ {a : Agent},
    Autonomous a →
    Capacity a →
    CIA_Autonomous a

/--
Derived theorem:

An agent who is Autonomous and has Capacity is CIA‑Autonomous.
-/
theorem CIA_from_capacity
  {a : Agent}
  (hAut : Autonomous a)
  (hCap : Capacity a) :
  CIA_Autonomous a :=
by
  exact cia_from_aut_and_cap hAut hCap

end SigmaR
