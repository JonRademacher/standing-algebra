import Mathlib

namespace SigmaSolve.RH
open Complex

/-- Abstract bounded-to-global bridge. The predicates are parameters, so this theorem
    creates no zeta facts and introduces no axioms. -/
theorem global_iff_all_bounded
    (NontrivialZero OnCriticalLine : Complex -> Prop) :
    (forall rho, NontrivialZero rho -> OnCriticalLine rho) <->
      (forall T : Real, 0 < T -> forall rho,
        NontrivialZero rho -> abs rho.im <= T -> OnCriticalLine rho) := by
  constructor
  . intro h T hT rho hz hheight
    exact h rho hz
  . intro h rho hz
    let T : Real := abs rho.im + 1
    have hT : 0 < T := by
      dsimp [T]
      linarith [abs_nonneg rho.im]
    have hheight : abs rho.im <= T := by
      dsimp [T]
      linarith
    exact h T hT rho hz hheight

/-- Specialization to the critical-line predicate. -/
theorem rh_shape_iff_all_bounded
    (NontrivialZero : Complex -> Prop) :
    (forall rho, NontrivialZero rho -> rho.re = (1 : Real) / 2) <->
      (forall T : Real, 0 < T -> forall rho,
        NontrivialZero rho -> abs rho.im <= T -> rho.re = (1 : Real) / 2) := by
  simpa using global_iff_all_bounded NontrivialZero
    (fun rho : Complex => rho.re = (1 : Real) / 2)

end SigmaSolve.RH
