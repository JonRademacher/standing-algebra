import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Interfaces (Signature Closure)
###############################################################################

This file centralizes *all* cross-layer structural interface symbols used by
Valuation layers (WellFormedness, Measures, MeasurementLimits, Relevance,
Monotonicity, AntiOptimization, and Equivalence).

It is a pure signature file:
• no axioms
• no theorems
• no definitions

Its role is to make all inference boundaries explicit and reviewable.
###############################################################################
-/

namespace SigmaR

/-!
------------------------------------------------------------------------------
0. Canonical type aliases
------------------------------------------------------------------------------
-/

abbrev Val : Type := Nat
abbrev Measure : Type := Agent → State → Val
abbrev PredAS : Type := Agent → State → Prop
abbrev PredS  : Type := State → Prop
abbrev Obj    : Type := State → Val

/-!
------------------------------------------------------------------------------
1. WellFormedness interfaces (structural legality)
------------------------------------------------------------------------------
-/

constant WellFormed : Measure → Prop
constant IsMeasure : Measure → Prop

constant ContextBound : Measure → Prop
constant IsGlobalScope : Measure → Prop
constant IsLocalScope : Measure → Prop

constant RestrictsDomain : Measure → Prop
constant StructurallyConstant : Measure → Prop

constant CompatibleDomainCodomain : Measure → Measure → Prop
constant DependsOn : Measure → Measure → Prop

constant Project : Measure → Measure
constant Restrict : Measure → PredAS → Measure

/-!
------------------------------------------------------------------------------
2. Cross-layer meta predicates (blocked by WellFormedness)
------------------------------------------------------------------------------
-/

constant TrueMeasure : Measure → Prop
constant ValidMeasure : Measure → Prop
constant LegitimateMeasure : Measure → Prop
constant ConstrainsInterpretation : Measure → Prop

/-!
------------------------------------------------------------------------------
3. Monotonicity interface
------------------------------------------------------------------------------
-/

constant StateLe : State → State → Prop

/-!
------------------------------------------------------------------------------
4. MeasurementLimits interfaces (observation & epistemic limits)
------------------------------------------------------------------------------
-/

constant Observable : Agent → State → Prop
constant Measured : Agent → State → Val

constant PerfectMeasurement : Agent → State → Prop
constant Noisy : Agent → State → Prop
constant Error : Agent → State → Prop

constant Understands : Agent → State → Prop
constant Controls : Agent → State → Prop

constant Optimizes : Obj → Prop

constant Causes : State → State → Prop
constant StateExists : PredS

constant MeasurementLimited : Agent → State → Prop
constant ConstrainsState : PredS

constant SystemInvalid : Prop
constant Failure : PredS

/-!
------------------------------------------------------------------------------
5. Relevance / Frame / Plurality interfaces
------------------------------------------------------------------------------
-/

constant IPFA : Agent → State → Prop
constant PFA : Set Agent → State → Prop

constant Frame : Type
constant ObservableInFrame : Agent → Frame → State → Prop
constant FrameSucc : Frame → Frame → Prop

/-!
------------------------------------------------------------------------------
6. AntiOptimization interfaces (forbidden inference patterns)
------------------------------------------------------------------------------
These predicates *name* teleological or instrumental interpretations.
They do not define them.
------------------------------------------------------------------------------ -/

-- Objective formation & targeting
constant GlobalObjective : Obj → Prop
constant GeneratedFromMeasure : Obj → Measure → Prop
constant TargetsMeasure : Obj → Measure → Prop

-- Aggregation / scalar collapse
constant AggregatesFromMeasure : Obj → Measure → Prop
constant Scalarizes : Set Measure → Obj → Prop

-- Measure–measure misuse
constant Compensates : Measure → Measure → Prop
constant TradeoffJustifies : Measure → Measure → Prop
constant ProxiesFor : Measure → Measure → Prop
constant InducesRanking : Measure → Prop

-- Semantic / teleological interpretation
constant TreatedAsUtility : Measure → Prop
constant TreatedAsWelfare : Measure → Prop
constant InterpretedAsImprovement : Measure → Prop

-- Dynamics / guarantees explicitly *not* assumed
constant Converges : Measure → Prop
constant HasEquilibrium : Measure → Prop
constant HasFixedPoint : Measure → Prop
constant GuaranteesProgress : Measure → Prop
constant AssumesSelection : Measure → Prop

-- Metric manipulation
constant GamesMetric : Obj → Measure → Prop

/-!
------------------------------------------------------------------------------
7. Equivalence interfaces (purely relational, non-teleological)
------------------------------------------------------------------------------
These predicates name equivalence relations and explicitly
forbidden equivalence-based collapses.
------------------------------------------------------------------------------ -/

-- Core equivalence relation
constant EquivalentMeasures : Measure → Measure → Prop

-- Illicit consequences of equivalence
constant EquivalenceInducesOrdering : Measure → Measure → Prop

-- Contextual scoping of equivalence
constant EquivalenceContext : Type
constant EquivalentInContext :
  EquivalenceContext → Measure → Measure → Prop

end SigmaR
