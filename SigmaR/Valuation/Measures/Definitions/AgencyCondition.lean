import SigmaR.StandingAlgebra_FormalCore

/-!
###############################################################################
# Agency Condition
###############################################################################

This file introduces a structural condition associated
with agency.

Agency is not assumed to be autonomy, authority,
or moral responsibility.
###############################################################################
-/

namespace SigmaR.Valuation.Measures.Definitions

/--
AgencyCondition i indicates that agent i satisfies
a structural agency-related condition under some theory.
-/
axiom AgencyCondition : Agent → Prop

end SigmaR.Valuation.Measures.Definitions
