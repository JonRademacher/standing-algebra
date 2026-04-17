import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
import SigmaR.Justifications.Core_Legitimacy.DirectedRepair_Justification
/-!
###############################################################################
# Justification of Structural Debt
###############################################################################
Standing Algebra requires that autonomy‑reducing operations generate
persistent obligations to repair.
From *On Relevance*:
 • By stripping autonomy from others, offenders incur proportional
   sacrifice of their own autonomy.
This implies:
 • Autonomy loss is not erased after intervention.
 • It persists as a standing claim.
 • Future legitimacy requires remediation.
Structural Debt therefore functions as autonomy‑loss memory across
system states.
This file introduces predicates capturing:
 • StructuralDebt incurred by autonomy‑reducing operations.
 • DebtDissipated via directed repair.
and encodes the requirement that legitimacy entails the possibility
of structural debt dissipation.
-/
namespace SigmaR
/-- Predicate: the operation incurs structural debt at state `s`. -/
constant StructuralDebt : Operation → State → Prop
/-- Predicate: structural debt incurred by `F` at `s`
   is dissipated via directed repair. -/
constant DebtDissipated : Operation → State → Prop
/--
Tier‑2 legitimacy axiom:
If an operation is Legitimate and incurs structural debt,
then at every state the possibility of dissipation via repair
must obtain.
-/
axiom debt_requires_repair :
 ∀ {F : Operation},
   Legitimate F →
     ∀ s : State,
       StructuralDebt F s →
       DebtDissipated F s
/--
Derived theorem:
Legitimacy implies structural debt must be dissipatable.
-/
theorem StructuralDebt_requires_repair
 {F : Operation}
 (hLeg : Legitimate F) :
 ∀ s : State,
   StructuralDebt F s →
   DebtDissipated F s :=
by
 intros s hDebt
 exact debt_requires_repair hLeg s hDebt
end SigmaR
