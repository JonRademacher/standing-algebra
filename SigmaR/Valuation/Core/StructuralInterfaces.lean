import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Interfaces (Signature Closure)
###############################################################################

Purpose
-------
This file centralizes *all* cross-layer structural interface symbols used by
Valuation layers (WellFormedness, Measures, MeasurementLimits, Relevance, and
Monotonicity). It is a signature file: it introduces *no axioms* and therefore
adds *no commitments*.

Design Requirements
-------------------
1) Single source of truth: every interface symbol is declared exactly once.
2) No semantic commitments: only declarations, no theorems, no axioms.
3) Stable arities: each predicate/function has one canonical type.
4) No collisions: names are chosen to avoid clashes with Lean core and with
   existing SigmaR symbols (especially "Exists" and "Successor").
5) Import discipline: any file that references these interface symbols should
   import this module rather than redeclare symbols locally.

If any file redeclares one of these symbols, airtightness is compromised
(by ambiguity or shadowing).
###############################################################################
-/

namespace SigmaR

/-!
------------------------------------------------------------------------------
0. Canonical type aliases used across Valuation layers
------------------------------------------------------------------------------
These aliases make arity explicit and allow future codomain changes
without rewriting the whole codebase.
------------------------------------------------------------------------------ -/

abbrev Val : Type := Nat
abbrev Measure : Type := Agent → State → Val
abbrev PredAS : Type := Agent → State → Prop
abbrev PredS  : Type := State → Prop
abbrev Obj    : Type := State → Val

/-!
------------------------------------------------------------------------------
1. WellFormedness interface symbols (structural legality)
------------------------------------------------------------------------------
These do NOT define what well-formedness *means*; they only provide stable
names/arity for the structural predicates used by the WellFormedness axioms.
------------------------------------------------------------------------------ -/

constant WellFormed : Measure → Prop
constant IsMeasure : Measure → Prop

constant ContextBound : Measure → Prop
constant IsGlobalScope : Measure → Prop
constant IsLocalScope : Measure → Prop

/-- Structural domain restriction marker (e.g., implicit partiality). -/
constant RestrictsDomain : Measure → Prop

/-- Structural triviality marker (e.g., ignores Agent and State). -/
constant StructurallyConstant : Measure → Prop

/-- Structural compatibility relation for chaining/composition policies. -/
constant CompatibleDomainCodomain : Measure → Measure → Prop

/-- Structural dependency relation (for acyclicity / no-self-dependence). -/
constant DependsOn : Measure → Measure → Prop

/-- Abstract projection operator on measures (must not be assumed admissible). -/
constant Project : Measure → Measure

/-- Abstract restriction operator (must not be assumed admissible). -/
constant Restrict : Measure → PredAS → Measure

/-!
------------------------------------------------------------------------------
2. Cross-layer "meta" predicates referenced by WellFormedness scope blockers
------------------------------------------------------------------------------
These are intentionally uninterpreted placeholders for higher layers.
WellFormedness blocks implications into these predicates.
------------------------------------------------------------------------------ -/

constant TrueMeasure : Measure → Prop
constant ValidMeasure : Measure → Prop
constant LegitimateMeasure : Measure → Prop

/-- Used only to express "WellFormedness does not constrain interpretation". -/
constant ConstrainsInterpretation : Measure → Prop

/-!
------------------------------------------------------------------------------
3. Monotonicity interface symbol (abstract state preorder)
------------------------------------------------------------------------------
Centralized here to avoid multiple "StateLe" declarations across files.
------------------------------------------------------------------------------ -/

constant StateLe : State → State → Prop

/-!
------------------------------------------------------------------------------
4. MeasurementLimits interface symbols (observation, noise, limits)
------------------------------------------------------------------------------
These are *observational* interfaces. They do not assert existence, accuracy,
or epistemic authority; they merely provide stable symbols used by the
MeasurementLimits axioms.
------------------------------------------------------------------------------ -/

constant Observable : Agent → State → Prop
constant Measured : Agent → State → Val

constant PerfectMeasurement : Agent → State → Prop
constant Noisy : Agent → State → Prop
constant Error : Agent → State → Prop

constant Understands : Agent → State → Prop
constant Controls : Agent → State → Prop

/-- Optimization marker on objectives; AntiOptimization forbids assuming this. -/
constant Optimizes : Obj → Prop

/-- Causal relation placeholder; MeasurementLimits forbids inferring this from observation. -/
constant Causes : State → State → Prop

/-- Ontic existence predicate for states (avoid name collision with Lean's Exists). -/
constant StateExists : PredS

/-- Measurement limitation marker for a given observer-context. -/
constant MeasurementLimited : Agent → State → Prop

/-- Marker used by scope files to block "limits on measurement ⇒ limits on reality". -/
constant ConstrainsState : PredS

/-- Global framework invalidity marker (kept propositional, not state-indexed). -/
constant SystemInvalid : Prop

/-- Generic failure predicate (used by occlusion/undetected failure patterns). -/
constant Failure : PredS

/-!
------------------------------------------------------------------------------
5. Relevance / Frame / Plurality interface symbols (non-ontologizing warrants)
------------------------------------------------------------------------------
These do not create legitimacy, truth, authority, obligation, or optimization.
They only provide stable predicates used by the Relevance layer.
------------------------------------------------------------------------------ -/

/-- Individual Personal Factual Access / personal warrant predicate. -/
constant IPFA : Agent → State → Prop

/-- Perceptual Frame Agreement predicate for a group at a state. -/
constant PFA : Set Agent → State → Prop

/-- Perceptual / descriptive frames. -/
constant Frame : Type

/-- Frame-indexed observability (frame dependence). -/
constant ObservableInFrame : Agent → Frame → State → Prop

/-- Successor relation on frames (avoid collision with Nat successor). -/
constant FrameSucc : Frame → Frame → Prop

end SigmaR
``
