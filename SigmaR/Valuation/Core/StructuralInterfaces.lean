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
• Independence (ALL inference firewalls)

This is a **pure signature file**:
• no axioms
• no theorems
• no definitions

Its sole purpose is to make *all inference boundaries explicit and reviewable*.
Nothing here asserts truth, validity, legitimacy, optimization, authority,
causation, or obligation.
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
4. MeasurementLimits interfaces
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
5. Relevance / Frame interfaces
------------------------------------------------------------------------------
-/

constant IPFA : Agent → State → Prop
constant PFA : Set Agent → State → Prop

constant Frame : Type
constant ObservableInFrame : Agent → Frame → State → Prop
constant FrameSucc : Frame → Frame → Prop

/-!
------------------------------------------------------------------------------
6. AntiOptimization interfaces
------------------------------------------------------------------------------
-/

constant GlobalObjective : Obj → Prop
constant GeneratedFromMeasure : Obj → Measure → Prop
constant TargetsMeasure : Obj → Measure → Prop

constant AggregatesFromMeasure : Obj → Measure → Prop
constant Scalarizes : Set Measure → Obj → Prop

constant Compensates : Measure → Measure → Prop
constant TradeoffJustifies : Measure → Measure → Prop
constant ProxiesFor : Measure → Measure → Prop
constant InducesRanking : Measure → Prop

constant TreatedAsUtility : Measure → Prop
constant TreatedAsWelfare : Measure → Prop
constant InterpretedAsImprovement : Measure → Prop

constant Converges : Measure → Prop
constant HasEquilibrium : Measure → Prop
constant HasFixedPoint : Measure → Prop
constant GuaranteesProgress : Measure → Prop
constant AssumesSelection : Measure → Prop

constant GamesMetric : Obj → Measure → Prop

/-!
------------------------------------------------------------------------------
7. Equivalence interfaces
------------------------------------------------------------------------------
-/

constant EquivalentMeasures : Measure → Measure → Prop
constant EquivalenceInducesOrdering : Measure → Measure → Prop

constant EquivalenceContext : Type
constant EquivalentInContext :
  EquivalenceContext → Measure → Measure → Prop

/-!
------------------------------------------------------------------------------
8. NonComparability interfaces
------------------------------------------------------------------------------
-/

constant NonComparable : Measure → Measure → Prop
constant BalancedAgainst : Measure → Measure → Prop

constant TreatedAsIgnorance : Measure → Measure → Prop
constant TreatedAsInaction : Measure → Measure → Prop

constant NonComparabilityContext : Type
constant NonComparableInContext :
  NonComparabilityContext → Measure → Measure → Prop

/-!
------------------------------------------------------------------------------
9. Independence misuse predicates (COMPLETE)
------------------------------------------------------------------------------
Each predicate names a *forbidden inference*, not a forbidden fact.
------------------------------------------------------------------------------ -/

-- Autonomy misuses
constant TreatedAsAutonomyFromStandingMeasure : Agent → State → Prop
constant TreatedAsAutonomyFromRoleState : Agent → State → Prop
constant TreatedAsAutonomyFromExitViable : Agent → State → Prop
constant TreatedAsAutonomyLostFromRiskLoad : Agent → State → Prop
constant TreatedAsAutonomyLostFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsAutonomyLostFromExitCollapse : Agent → State → Prop
constant TreatedAsAutonomyLostFromRiskInheritance : Agent → State → Prop
constant TreatedAsAutonomyFromDominationPressure : Agent → State → Prop

-- Capacity misuses
constant TreatedAsCapacityFromStandingMeasure : Agent → State → Prop
constant TreatedAsCapacityFromRoleState : Agent → State → Prop
constant TreatedAsCapacityFromExitViable : Agent → State → Prop
constant TreatedAsCapacityLostFromRiskLoad : Agent → State → Prop
constant TreatedAsCapacityLostFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsCapacityLostFromExitCollapse : Agent → State → Prop
constant TreatedAsCapacityLostFromRiskInheritance : Agent → State → Prop
constant TreatedAsCapacityLostFromDominationPressure : Agent → State → Prop

-- Consent misuses
constant TreatedAsConsentFromStandingMeasure : Agent → State → Prop
constant TreatedAsConsentFromRoleState : Agent → State → Prop
constant TreatedAsConsentFromExitViable : Agent → State → Prop
constant TreatedAsConsentInvalidFromRiskLoad : Agent → State → Prop
constant TreatedAsConsentInvalidFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsConsentInvalidFromExitCollapse : Agent → State → Prop
constant TreatedAsConsentInvalidFromRiskInheritance : Agent → State → Prop
constant TreatedAsConsentInvalidFromDominationPressure : Agent → State → Prop

-- Standing misuses
constant TreatedAsStandingFromRoleState : Agent → State → Prop
constant TreatedAsStandingFromExitViable : Agent → State → Prop
constant TreatedAsStandingFromRiskInheritance : Agent → State → Prop
constant TreatedAsStandingFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsStandingRevokedFromStructuralDebt : Agent → State → Prop
constant TreatedAsStandingRevokedFromExitCollapse : Agent → State → Prop
constant TreatedAsStandingRevokedFromDominationPressure : Agent → State → Prop

-- Structural debt misuses
constant TreatedAsStructuralDebtFromRiskLoad : Agent → State → Prop
constant TreatedAsStructuralDebtFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsStructuralDebtFromExitCollapse : Agent → State → Prop
constant TreatedAsStructuralDebtFromDominationPressure : Agent → State → Prop
constant TreatedAsStructuralDebtResolvedFromStandingMeasure : Agent → State → Prop
constant TreatedAsStructuralDebtResolvedFromRoleState : Agent → State → Prop

-- Exit viability / collapse misuses
constant TreatedAsExitViableFromStandingMeasure : Agent → State → Prop
constant TreatedAsExitViableFromRoleState : Agent → State → Prop
constant TreatedAsExitViableFromRiskLoad : Agent → State → Prop
constant TreatedAsExitViableFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsExitViableResolvedFromStructuralDebt : Agent → State → Prop
constant TreatedAsExitViableLostFromDominationPressure : Agent → State → Prop

constant TreatedAsExitCollapseFromStandingMeasure : Agent → State → Prop

-- Risk misuses
constant TreatedAsRiskFromStandingMeasure : Agent → State → Prop
constant TreatedAsRiskFromRoleState : Agent → State → Prop
constant TreatedAsRiskFromTemporalAccumulation : Agent → State → Prop
constant TreatedAsRiskFromStructuralDebt : Agent → State → Prop
constant TreatedAsRiskFromDominationPressure : Agent → State → Prop
constant TreatedAsRiskFromExitViable : Agent → State → Prop

-- Temporal accumulation misuses
constant TreatedAsTemporalAccumulationFromStandingMeasure : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromRiskLoad : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromStructuralDebt : Agent → State → Prop
constant TreatedAsTemporalAccumulationFromExitViable : Agent → State → Prop
constant TreatedAsTemporalAccumulationResolvedFromRoleState : Agent → State → Prop

-- Domination pressure misuses
constant TreatedAsDominationPressureFromStandingMeasure : Agent → State → Prop
constant TreatedAsDominationPressureFromRiskLoad : Agent → State → Prop
constant TreatedAsDominationPressureFromStructuralDebt : Agent → State → Prop
constant TreatedAsDominationPressureFromExitViable : Agent → State → Prop
constant TreatedAsDominationPressureFromTemporalAccumulation : Agent → State → Prop

end SigmaR
