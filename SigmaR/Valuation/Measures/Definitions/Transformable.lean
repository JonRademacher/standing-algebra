import SigmaR.StandingAlgebra_FormalCore
import SigmaR.Valuation.Measures.Definitions.Operation

/-!
###############################################################################
# Transformable
###############################################################################

This file introduces the primitive notion of transformability.

Transformability denotes the capacity to be changed by some operation.
###############################################################################
-/

namespace SigmaR

/--
Transformable i F means that applying operation F
changes agent i.
-/
constant Transformable : Agent → Operation → Prop

end SigmaR
