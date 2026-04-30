import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Well-Formed Measure Sets
###############################################################################

This file defines structural well-formedness conditions for sets
or collections of valuation measures used together.

It does NOT:
• impose relationships between measures
• permit inference between measures
• collapse multiple measures into a single scalar
• assert semantic compatibility

It ONLY constrains structural admissibility of measure collections.
###############################################################################
-/

namespace SigmaR

/--
A set of measures is well-formed if all members are individually
well-formed valuation measures.
-/
constant WellFormedMeasureSet :
  Set Measure → Prop

/--
A set of measures must not contain structurally redundant or
self-referential measures.
-/
constant MeasureSetNoRedundancy :
  Set Measure → Prop

/--
Measures grouped together must have compatible domains and codomains.
This does not imply semantic compatibility or comparability.
-/
constant MeasureSetDomainCompatible :
  Set Measure → Prop

/--
A well-formed measure set does not imply any aggregation,
ordering, or tradeoff between its members.
-/
constant MeasureSetNonAggregative :
  Set Measure → Prop

end SigmaR
