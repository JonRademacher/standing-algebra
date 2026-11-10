import Mathlib

namespace SigmaSolve.RH

/-- Abstract finite off-line defect: multiplicity count of elements not satisfying `OnLine`. -/
def offLineDefect {α : Type} [DecidableEq α]
    (OnLine : α → Prop) [DecidablePred OnLine]
    (height : α → ℝ) (zeros : Multiset α) (T : ℝ) : ℕ :=
  ((zeros.filter fun z => height z ≤ T).filter fun z => ¬ OnLine z).card

/-- Defect is monotone under enlargement of the height window. -/
theorem offLineDefect_mono {α : Type} [DecidableEq α]
    (OnLine : α → Prop) [DecidablePred OnLine]
    (height : α → ℝ) (zeros : Multiset α) {T U : ℝ}
    (hTU : T ≤ U) :
    offLineDefect OnLine height zeros T ≤
      offLineDefect OnLine height zeros U := by
  classical
  apply Multiset.card_le_card
  intro z hz
  simp only [offLineDefect, Multiset.mem_filter] at hz ⊢
  exact ⟨⟨hz.1.1, le_trans hz.1.2 hTU⟩, hz.2⟩

/-- In a finite landscape, zero defect at a height containing all elements is equivalent
    to every represented element being on-line. -/
theorem zero_defect_iff_all_on_line {α : Type} [DecidableEq α]
    (OnLine : α → Prop) [DecidablePred OnLine]
    (height : α → ℝ) (zeros : Multiset α) (T : ℝ)
    (hcover : ∀ z ∈ zeros, height z ≤ T) :
    offLineDefect OnLine height zeros T = 0 ↔
      ∀ z ∈ zeros, OnLine z := by
  classical
  simp [offLineDefect, hcover]

end SigmaSolve.RH
