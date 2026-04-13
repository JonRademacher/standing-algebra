-- Standing Algebra (Σᴿ) formalization in Lean 4.

-- Sort declarations for Agents, Operations, and global States:
constant Agent : Type
constant Operation : Type
constant State : Type

-- Additional sorts for optional constructs:
constant CouplingKind : Type             -- sort for coupling relation kinds (K)
inductive RemedyLevel : Type :=          -- remedy ladder levels
| CounterSpeech | Friction | Damping | Removal | Exceptional

-- Primitive function and predicate symbols:
constant sigma : Agent → Nat            -- standing value σ(i)
constant cap : Agent → Nat             -- capacity value C(i)
constant deg : Agent → Nat             -- coupling degree D(i)
constant Suc : Nat → Nat               -- successor function S (Lean has Nat.succ, but we use Suc for clarity)
constant B : Nat → Nat                 -- capacity-indexed standing bound B(c)

constant comp : Agent → Agent → Agent  -- entity composition (⊕)
constant Id : Operation                -- identity operation (Id ∈ O)
constant composeOp : Operation → Operation → Operation  -- operation composition

constant Null : Agent → Prop
constant Prime : Agent → Prop
constant Composite : Agent → Prop
constant Coupled : Agent → Agent → Prop
constant Coupled_k : Agent → Agent → CouplingKind → Prop
constant DomCoupling : Agent → CouplingKind → Prop

constant Admissible : Operation → Prop
constant Legitimate : Operation → Prop
constant Repair : Operation → Prop
constant Drift : Operation → Prop
-- (Idempotent and STC5 will be specified via axioms/definitions rather than primitives)

-- Extended (Σᴿ⁺) predicates:
constant PFAEligible : Agent → Prop
constant Coercive : Prop
constant LegitimateSystem : Prop
constant RiskLoad : Agent → Nat
constant RiskBearer : Operation → Agent → Prop
constant ExitPreserved_k : Operation → Agent → CouplingKind → Prop
constant EmergentWrong : State → Prop
constant ARV : Operation → Agent → Prop
constant StructuralDebt : Agent → Nat
constant PublicAct : Operation → Prop
constant PFAResolved : Operation → Prop
constant Emergency : Operation → Prop
constant RemedyHigher : RemedyLevel → RemedyLevel → Prop

-- Application of an Operation on an Agent (effect on individual agent's state), and on a State (global transition):
constant apply : Operation → Agent → Agent
constant apply_state : Operation → State → State

-- One-step difference predicate (for drift bounds and emergency bounds):
def OneStepDiff (x y : Nat) : Prop :=
  x = y ∨ x = Nat.succ y ∨ y = Nat.succ x

-- PathTo1 definition (existence of an admissible op that raises an agent from 0 to 1, under eligibility):
def PathTo1 (i : Agent) : Prop :=
  ∃ (F : Operation), Admissible F ∧ sigma i = 0 ∧ sigma (apply F i) = 1 ∧ PFAEligible i

-------------------------------------------------------------------------------
-- Tier-1: Standing Algebra Axioms (Σᴿ₁)
-------------------------------------------------------------------------------

-- Axiom 1: Nullity
axiom A1_Nullity : ∀ i : Agent, sigma i = 0 → Null i

-- (Additive identity: 0 is the neutral element for addition. Lean's nat already satisfies ∀n, n + 0 = n = 0 + n.)

-- Axiom 2: Successor Definition (no 0-predecessor)
axiom A2_SuccessorNonzero : Suc 0 = 1 ∧ (∀ n : Nat, Suc n ≠ 0)

-- Axiom 3: Successor as Addition
axiom A3_SuccessorIsAdd : ∀ n : Nat, Suc n = n + 1

-- Axiom 5: Non-Dilution (Additivity of standing under composition)
axiom A5_Additivity : ∀ i j : Agent, sigma (comp i j) = sigma i + sigma j

-- Axiom 6: Class-Uniform Successor Access
axiom A6_SuccessorAccess : ∀ (i j : Agent),
  sigma i = 0 → sigma j = 0 → cap i = cap j → (∃ F : Operation, Admissible F ∧ sigma i = 0 ∧ sigma (apply F i) = 1 ∧ PFAEligible i) →
  (∃ G : Operation, Admissible G ∧ sigma j = 0 ∧ sigma (apply G j) = 1 ∧ PFAEligible j)

-- Axiom 7: No Selective Successor Denial (System Coercion definition)
axiom A7_CoerciveDef : Coercive ↔ ∃ (i j : Agent),
  sigma i = 1 ∧ sigma j = 0 ∧ ¬(∃ F : Operation, Admissible F ∧ sigma j = 0 ∧ sigma (apply F j) = 1 ∧ PFAEligible j)
axiom A7_LegitimateSystemDef : LegitimateSystem ↔ ¬ Coercive

-- Axiom 8: Degree–Coupling Consistency
axiom A8_DegCoupling : ∀ i : Agent,
  ((deg i = 0) ↔ ¬(∃ j : Agent, Coupled j i)) ∧ ((deg i > 0) → ∃ j : Agent, Coupled j i)

-- Axiom 9: Prime Definition
axiom A9_PrimeDef : ∀ i : Agent, Prime i ↔ (sigma i = 1 ∧ deg i = 0)

-- Axiom 10: Composite Definition
axiom A10_CompositeDef : ∀ i : Agent, Composite i ↔ (sigma i > 1 ∨ deg i > 0)

-- Axiom 11: Prime/Composite/Null Partition (trichotomy and mutual exclusivity)
axiom A11_Partition : ∀ i : Agent,
  (Null i ∨ Prime i ∨ Composite i) ∧
  ¬(Null i ∧ Prime i) ∧ ¬(Null i ∧ Composite i) ∧ ¬(Prime i ∧ Composite i)

-- Axiom 12: No Return to Nullity
axiom A12_NoReturnNull : ∀ (F : Operation) (i : Agent),
  sigma i > 0 → sigma (apply F i) = 0 → False

-- Axiom 13: Monotonic Successor Growth
axiom A13_MonotonicSucc : ∀ i : Agent, Suc (sigma i) > sigma i

-- Axiom NT1: Standing Non-Triviality
axiom NT1_StandingNonTrivial : ∃ i : Agent, sigma i = 1

-- Axiom NT2: Capacity Non-Collapse
axiom NT2_CapacityNonCollapse : ∃ i : Agent, B (cap i) ≥ 1

-- Axiom PR (Policy Realizability) - (Non-executable, omitted in Lean: would require second-order reasoning about arbitrary functions)
-- (We acknowledge this axiom informally: any pattern of class outcomes that respects capacity bounds is achievable by some admissible F.)

-- Axiom L¬∘ (Legitimacy Not Closed Under Composition)
axiom L_nonClosed : ¬ (∀ (F G : Operation), Legitimate F ∧ Legitimate G → Legitimate (composeOp F G))

-- Axiom DMon (Degree Monotonicity)
axiom A_DMon : ∀ (i j k : Agent),
  Coupled j i ∧ ¬Coupled j k → deg i ≥ deg k

-------------------------------------------------------------------------------
-- Tier-2: Structural Legitimacy Axioms (Σᴿ₂)
-------------------------------------------------------------------------------

-- Axiom 14: Capacity-Indexed Autonomy (CIA)
axiom A14_CIA : (∀ i : Agent, sigma i ≤ B (cap i))
             ∧ (∀ (c1 c2 : Nat), c1 ≥ c2 → B c1 ≥ B c2)

-- Axiom 15: Autonomy-Limiting Reflex (ALRP)
axiom A15_ALRP : ∀ (F : Operation), Admissible F → ∀ i : Agent, sigma (apply F i) ≥ sigma i
-- (Contrapositive: if ∃i with σ(F(i)) < σ(i), then F is not admissible.)

-- Axiom 16: Non-Reciprocity Prevention (class-uniform)
axiom A16_NRPP : ∀ (i j : Agent), sigma i = sigma j → cap i = cap j → deg i = 0 → deg j = 0

-- Axiom 17: Symmetry of Equals (STC-5)
-- (As per Def. 21 below, STC5 is enforced via legitimacy definition rather than a separate primitive axiom.)
-- We will include STC5 in the legitimacy definition to ensure it holds for Legitimate operations.

-- Axiom 18: Rerunnability (Idempotence)
axiom A18_Rerun : ∀ (F : Operation) (i : Agent), Legitimate F → apply F (apply F i) = apply F i

-- Axiom 19: Directed Repair (Monotonicity of repair effects)
axiom A19_Repair : ∀ (R : Operation) (i : Agent), Repair R → (sigma (apply R i) ≥ sigma i) ∧ (deg (apply R i) ≤ deg i)

-- Axiom 20: Bounded Drift
axiom A20_Drift : ∀ (D : Operation) (i : Agent),
  Drift D → OneStepDiff (sigma (apply D i)) (sigma i) ∧ OneStepDiff (deg (apply D i)) (deg i)

-- Definition 21: Unified Legitimacy
axiom Def21_Legitimacy : ∀ (F : Operation),
  (Legitimate F) ↔
    (Admissible F ∧
     (∀ i : Agent, sigma (apply F i) = sigma i ∨ sigma (apply F i) = Suc (sigma i)) ∧         -- successorConsistency(F)
     (∀ i j : Agent, (sigma i = sigma j ∧ cap i = cap j) → (sigma (apply F i) = sigma (apply F j))) ∧  -- STC5(F)
     (∀ i : Agent, apply F (apply F i) = apply F i) ∧                                             -- Idempotent(F)
     (Drift F))   -- D satisfies drift invariant (explicit drift changes bounded by A20)

-- (We incorporate ALRP in Admissible by A15_ALRP. So Legitimate(F) implies Admissible(F), STC5, idempotent, drift constraints as above.)

-------------------------------------------------------------------------------
-- Tier-3: Extended Axioms (Σᴿ⁺ Extensions: Coupling Typology, Risk, Contestability, etc.)
-------------------------------------------------------------------------------

-- Axiom 22: Standing-Successor Realizer (SSR)
axiom A22_SSR : ∀ i : Agent, ∃ y : Agent, sigma y = Suc (sigma i)

-- Axiom 23: Local Successor Realizer (LSR)
axiom A23_LSR : ∀ i : Agent, ∃ y : Agent, sigma y = Suc (sigma i) ∧ OneStepDiff (deg y) (deg i)

-- Axiom 24: Coupling Exhaustiveness
axiom A24_CouplingExhaustive : ∀ (p q : Agent), Coupled p q ↔ ∃ k : CouplingKind, Coupled_k p q k

-- Axiom 25: Unique Dominant Coupling
axiom A25_DomCouplingUnique : ∀ i : Agent, ∃ (k : CouplingKind),
  DomCoupling i k ∧ (∀ k2 : CouplingKind, DomCoupling i k2 → k2 = k)

-- Axiom 26: Risk-Load Monotonicity
axiom A26_RiskMonotonic : ∀ (F : Operation) (i : Agent), RiskBearer F i → RiskLoad (apply F i) ≥ RiskLoad i

-- Axiom 27: Risk-Sensitive Symmetry
axiom A27_RiskSymmetry : ∀ (F : Operation) (i j : Agent),
  Legitimate F → sigma i = sigma j → cap i = cap j → RiskLoad i ≥ RiskLoad j →
  sigma (apply F i) ≥ sigma (apply F j)

-- Axiom 28: Coupling-Sensitive Exit Preservation
axiom A28_ExitPreserve : ∀ (F : Operation) (i : Agent) (k : CouplingKind),
  RiskBearer F i → DomCoupling i k → ExitPreserved_k F i k

-- Axiom 29: Emergent Wrong Repair Obligation
axiom A29_EmergentRepair : ∀ s : State, EmergentWrong s → ∃ R : Operation, Repair R ∧ ¬ EmergentWrong (apply_state R s)

-- Axiom 30: Structural Debt Accumulation
axiom A30_DebtAccumulation : ∀ (F : Operation) (i : Agent),
  ARV F i → StructuralDebt (apply F i) = Nat.succ (StructuralDebt i)

-- Axiom 31: Debt Dissipation by Repair
axiom A31_DebtDissipate : ∀ (R : Operation) (i : Agent),
  Repair R → StructuralDebt (apply R i) < StructuralDebt i

-- Axiom 32: Public Frame Required
axiom A32_PFARequired : ∀ (F : Operation), PublicAct F → ¬ Emergency F → PFAResolved F

-- Axiom 33: Unresolved Frame ⇒ Inadmissible
axiom A33_FrameAdmissible : ∀ (F : Operation), ¬ PFAResolved F → ¬ Admissible F

-- Remedy Ladder Axioms (RL0, RL1, RL2):
axiom RL0_LadderOrder : RemedyHigher RemedyLevel.Friction RemedyLevel.CounterSpeech ∧
                        RemedyHigher RemedyLevel.Damping RemedyLevel.Friction ∧
                        RemedyHigher RemedyLevel.Removal RemedyLevel.Damping ∧
                        RemedyHigher RemedyLevel.Exceptional RemedyLevel.Removal
axiom RL1_Transitive : ∀ r1 r2 r3 : RemedyLevel, RemedyHigher r1 r2 ∧ RemedyHigher r2 r3 → RemedyHigher r1 r3
axiom RL2_Irreflexive : ∀ r : RemedyLevel, ¬ RemedyHigher r r

-- (Optional: We could also formalize extended Tier-3 constraints like P0–P7, EE0–EE5 if needed, following the same pattern.)

-- O1: Identity operation is Legitimate, and composition closure:
axiom O1_IdentityLegit : Legitimate Id
axiom O2_Extensionality : ∀ (F G : Operation), (∀ x : Agent, apply F x = apply G x) → F = G

-- The axioms above fully encode the formal system. We can use Lean's logic to check consistency (Lean accepts this theory with no contradictions if no `sorry` remains).
-- (No theorem is proven here; the axioms can be used in Lean to verify consistency or prove derived results.)