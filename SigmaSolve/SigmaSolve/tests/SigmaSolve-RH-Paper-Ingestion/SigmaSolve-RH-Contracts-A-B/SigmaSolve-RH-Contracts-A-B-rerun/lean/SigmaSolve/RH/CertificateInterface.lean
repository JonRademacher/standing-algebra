import Mathlib
import SigmaSolve.RH.CountGeometry

namespace SigmaSolve.RH
open Complex
noncomputable section

/-- Height-window predicate shared by Contracts A and B. -/
def InWindow (T : ℝ) (ρ : ℂ) : Prop := |ρ.im| ≤ T

/-- A finite multiplicity certificate. Repeated multiset values represent multiplicity. -/
structure BoundedZeroCertificate (T : ℝ) where
  zeros : Multiset ℂ
  sound : ∀ ρ ∈ zeros, IsNontrivialZero ρ ∧ InWindow T ρ
  complete : ∀ ρ, IsNontrivialZero ρ → InWindow T ρ → ρ ∈ zeros

/-- Count equality yields the bounded target for every point represented by the certificate. -/
theorem certificate_on_line_of_count_eq
    {T : ℝ} (C : BoundedZeroCertificate T)
    (hcount : N0 C.zeros = N C.zeros) :
    ∀ ρ ∈ C.zeros, OnCriticalLine ρ := by
  exact (n0_eq_n_iff C.zeros).mp hcount

/-- With certificate completeness, count equality yields the full bounded statement. -/
theorem bounded_statement_of_certificate
    {T : ℝ} (C : BoundedZeroCertificate T)
    (hcount : N0 C.zeros = N C.zeros) :
    ∀ ρ, IsNontrivialZero ρ → InWindow T ρ → OnCriticalLine ρ := by
  intro ρ hzero hwindow
  exact certificate_on_line_of_count_eq C hcount ρ
    (C.complete ρ hzero hwindow)

/-- If every positive window has a complete certificate with equal counts, the global
pointwise target follows. This theorem does not prove that such certificates exist. -/
theorem global_of_certificates
    (C : ∀ T : ℝ, 0 < T → BoundedZeroCertificate T)
    (hcount : ∀ T : ℝ, ∀ hT : 0 < T,
      N0 (C T hT).zeros = N (C T hT).zeros) :
    ∀ ρ, IsNontrivialZero ρ → OnCriticalLine ρ := by
  rw [zeta_global_iff_all_bounded]
  intro T hT ρ hzero hwindow
  exact bounded_statement_of_certificate (C T hT) (hcount T hT)
    ρ hzero hwindow

end
end SigmaSolve.RH
