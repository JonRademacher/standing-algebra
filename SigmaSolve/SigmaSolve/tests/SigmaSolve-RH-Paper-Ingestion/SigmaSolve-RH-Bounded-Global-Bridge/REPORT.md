# RH bounded-to-global bridge

**Terminal state:** `PARTIAL_LEMMAS_VERIFIED`

A better bridge was found and executed. Count functions are not needed to remove the height parameter logically. For any predicate `NontrivialZero` and critical-line predicate `OnCriticalLine`,

`(forall rho, NontrivialZero rho -> OnCriticalLine rho)`

is equivalent to

`forall T>0, forall rho, NontrivialZero rho -> abs(im rho)<=T -> OnCriticalLine rho`.

The reverse direction chooses `T = abs(im rho)+1`. This avoids positive-height/conjugation conventions and requires neither finiteness nor multiplicity. The abstract executable model passed **111,111** finite zero landscapes.

The count-geometry theorem remains useful for bounded certification, but it is now correctly classified as one realization of bounded completeness rather than the logical bridge itself.

The new frontier is analytic: bind `NontrivialZero` to Mathlib's `riemannZeta`, use the available isolated-zero/order/divisor infrastructure to construct finite bounded certificates when wanted, and prove the bounded property for every T. That last step remains equivalent in difficulty to RH.
