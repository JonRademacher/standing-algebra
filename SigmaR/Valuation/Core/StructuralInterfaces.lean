import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Structural Interfaces (Signature Closure)
###############################################################################

This file centralizes *all* cross-layer structural interface symbols used by
Valuation layers:

• WellFormedness
• MeasurementLimits
• Relevance
• Monotonicity
• AntiOptimization
• Equivalence
• NonComparability

This is a **pure signature file**:
• no axioms
• no theorems
• no definitions

Its sole purpose is to make *all inference boundaries explicit and reviewable*.
Nothing here asserts truth, validity, legitimacy, optimization, or authority.
###############################################################################
-/

namespace SigmaR

/-!
------------------------------------------------------------------------------
0. Canonical type aliases
------------------------------------------------------------------------------
These aliases make arity explicit and prevent accidental semantic drift.
------------------------------------------------------------------------------ -/

abbrev Val : Type := Nat
abbrev Measure : Type := Agent → State → Val
abbrev PredAS : Type := Agent → State → Prop
abbrev PredS  : Type := State → Prop
abbrev Obj    : Type := State → Val

/-!
------------------------------------------------------------------------------
1. WellFormedness interfaces (structural legality)
------------------------------------------------------------------------------
These predicates govern *structural admissibility only*.
They say nothing about truth, validity, legitimacy, or meaning.
------------------------------------------------------------------------------ -/

constant WellFormed : Measure → Prop
/-- Measure is admitted structurally as a valuation measure. -/
constant IsMeasure : Measure → Prop

/-- Measure is explicitly bound to an agent–state context. -/
constant ContextBound : Measure → Prop

/-- Measure is explicitly declared globally scoped. -/
constant IsGlobalScope : Measure → Prop

/-- Measure is explicitly declared locally scoped. -/
constant IsLocalScope : Measure → Prop

/-- Measure relies on an implicit or restricted domain. -/
constant RestrictsDomain : Measure → Prop

/-- Measure is structurally trivial (e.g. ignores Agent and State). -/
constant StructurallyConstant : Measure → Prop

/-- Codomain of one measure is structurally compatible with another. -/
constant CompatibleDomainCodomain : Measure → Measure → Prop

/-- Structural dependency relation between measures. -/
constant DependsOn : Measure → Measure → Prop

/-- Abstract projection operator on measures (no preservation assumed). -/
constant Project : Measure → Measure

/-- Abstract restriction operator on measures (no preservation assumed). -/
constant Restrict : Measure → PredAS → Measure

/-!
------------------------------------------------------------------------------
2. Cross-layer meta predicates (blocked by WellFormedness)
------------------------------------------------------------------------------
These predicates belong to *higher layers*.
WellFormedness explicitly blocks inference into them.
------------------------------------------------------------------------------ -/

constant TrueMeasure : Measure → Prop
constant ValidMeasure : Measure → Prop
constant LegitimateMeasure : Measure → Prop
constant ConstrainsInterpretation : Measure → Prop

/-!
------------------------------------------------------------------------------
3. Monotonicity interface
------------------------------------------------------------------------------
Abstract preorder on states; carries no semantic meaning by itself.
------------------------------------------------------------------------------ -/

constant StateLe : State → State → Prop

/-!
------------------------------------------------------------------------------
4. MeasurementLimits interfaces (epistemic constraints)
------------------------------------------------------------------------------
These predicates describe limits on observation and diagnosis,
not on existence, truth, or legitimacy.
------------------------------------------------------------------------------ -/

constant Observable : Agent → State → Prop
constant Measured : Agent → State → Val

constant PerfectMeasurement : Agent → State → Prop
constant Noisy : Agent → State → Prop
constant Error : Agent → State → Prop

constant Understands : Agent → State → Prop
constant Controls : Agent → State → Prop

/-- Objective is treated as something to be optimized. -/
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
These predicates govern *warrant and perception*, not authority.
------------------------------------------------------------------------------ -/

constant IPFA : Agent → State → Prop
constant PFA : Set Agent → State → Prop

/-- Perceptual or descriptive frames. -/
constant Frame : Type

constant ObservableInFrame : Agent → Frame → State → Prop
constant FrameSucc : Frame → Frame → Prop

/-!
------------------------------------------------------------------------------
6. AntiOptimization interfaces (forbidden teleological inferences)
------------------------------------------------------------------------------
These predicates *name illicit inference patterns*.
They do not define goals, optimization, or value.
------------------------------------------------------------------------------ -/

-- Objective formation & targeting
/-- Objective is treated as globally governing valuation. -/
constant GlobalObjective : Obj → Prop

/-- Objective is endogenously generated from a valuation measure. -/
constant GeneratedFromMeasure : Obj → Measure → Prop

/-- Objective treats a valuation measure as its target. -/
constant TargetsMeasure : Obj → Measure → Prop

-- Aggregation / scalar collapse
/-- Objective aggregates information from a valuation measure. -/
constant AggregatesFromMeasure : Obj → Measure → Prop

/-- Multiple measures are collapsed into a single scalar objective. -/
constant Scalarizes : Set Measure → Obj → Prop

-- Measure–measure misuse
/-- One measure is treated as compensating for another. -/
constant Compensates : Measure → Measure → Prop

/-- Harm in one measure is justified by improvement in another. -/
constant TradeoffJustifies : Measure → Measure → Prop

/-- One measure is used as a proxy for another. -/
constant ProxiesFor : Measure → Measure → Prop

/-- Measure induces a ranking or ordering. -/
constant InducesRanking : Measure → Prop

-- Semantic / teleological interpretation
/-- Measure is interpreted as utility or preference satisfaction. -/
constant TreatedAsUtility : Measure → Prop

/-- Measure is interpreted as welfare. -/
constant TreatedAsWelfare : Measure → Prop

/-- Monotone change is interpreted as improvement. -/
constant InterpretedAsImprovement : Measure → Prop

-- Dynamics / guarantees explicitly *not* assumed
/-- Measure is assumed to converge. -/
constant Converges : Measure → Prop

/-- Measure is assumed to admit an equilibrium. -/
constant HasEquilibrium : Measure → Prop

/-- Measure is assumed to admit a fixed point. -/
constant HasFixedPoint : Measure → Prop

/-- Measure is assumed to guarantee progress. -/
constant GuaranteesProgress : Measure → Prop

/-- Measure is assumed to induce selection or fitness dynamics. -/
constant AssumesSelection : Measure → Prop

-- Metric manipulation
/-- Objective treats metric manipulation as success. -/
constant GamesMetric : Obj → Measure → Prop

/-!
------------------------------------------------------------------------------
7. Equivalence interfaces (purely relational)
------------------------------------------------------------------------------
Equivalence is non-teleological, non-global, and contextual.
------------------------------------------------------------------------------ -/

/-- Two valuation measures are treated as equivalent. -/
constant EquivalentMeasures : Measure → Measure → Prop

/-- Equivalence is treated as inducing an ordering. -/
constant EquivalenceInducesOrdering : Measure → Measure → Prop

/-- Context in which equivalence claims may hold. -/
constant EquivalenceContext : Type

/-- Measures are equivalent within a specific context. -/
constant EquivalentInContext :
  EquivalenceContext → Measure → Measure → Prop

/-!
------------------------------------------------------------------------------
8. NonComparability interfaces (hard semantic boundaries)
------------------------------------------------------------------------------
Non-comparability forbids tradeoffs, balancing, scalar comparison,
but does NOT imply ignorance or inaction.
------------------------------------------------------------------------------ -/

/-- Two valuation measures are non-comparable. -/
constant NonComparable : Measure → Measure → Prop

/-- Measures are treated as balanceable or offsetting. -/
constant BalancedAgainst : Measure → Measure → Prop

/-- Non-comparability is treated as epistemic ignorance. -/
constant TreatedAsIgnorance : Measure → Measure → Prop

/-- Non-comparability is treated as implying inaction. -/
constant TreatedAsInaction : Measure → Measure → Prop

/-- Context in which non-comparability claims may hold. -/
constant NonComparabilityContext : Type

/-- Measures are non-comparable within a specific context. -/
constant NonComparableInContext :
  NonComparabilityContext → Measure → Measure → Prop

end SigmaR
