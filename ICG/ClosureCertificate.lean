module

public import ICG.FiniteFiltration

@[expose] public section

namespace ICG

universe u v

/-- A closure certificate records the declared finite filtration, its fixed
admissibility regime, terminal survivors, and the unresolved residuals that
must remain represented. It contains no winner-selection field. -/
structure AccountableClosureCertificate
    (Candidate : Type u) (Residual : Type v)
    (Witness : Candidate → Prop) (Admissible : Candidate → Prop)
    (Unresolved : Residual → Prop)
    (Represented : Residual → Finset Candidate → Prop) where
  filter : AccountableFilter Candidate Witness
  initial : Finset Candidate
  history : Nat → Finset Candidate
  history_starts : history 0 = initial
  history_follows_filter :
    ∀ n, history (n + 1) = filter.retain (history n)
  terminalIndex : Nat
  survivors : Finset Candidate
  survivors_are_terminal : survivors = history terminalIndex
  terminal_survivors_admissible :
    ∀ ⦃candidate⦄, candidate ∈ survivors → Admissible candidate
  terminal_is_stable : filter.retain survivors = survivors
  residuals_preserved :
    ∀ residual, Unresolved residual → Represented residual survivors

namespace AccountableClosureCertificate

variable {Candidate : Type u} {Residual : Type v}
  {Witness : Candidate → Prop} {Admissible : Candidate → Prop}
  {Unresolved : Residual → Prop}
  {Represented : Residual → Finset Candidate → Prop}
  (certificate :
    AccountableClosureCertificate Candidate Residual Witness Admissible
      Unresolved Represented)

/-- The declared history is exactly the iteration of its fixed filter. -/
theorem history_eq_stage (n : Nat) :
    certificate.history n = certificate.filter.stage certificate.initial n := by
  induction n with
  | zero =>
      exact certificate.history_starts
  | succ n ih =>
      change certificate.history (n + 1) =
        certificate.filter.retain
          (certificate.filter.stage certificate.initial n)
      rw [certificate.history_follows_filter n, ih]

/-- Every removal in the certified history has its declared elimination witness. -/
theorem removed_has_witness (n : Nat) {candidate : Candidate}
    (hcurrent : candidate ∈ certificate.history n)
    (hremoved : candidate ∉ certificate.history (n + 1)) :
    Witness candidate := by
  apply certificate.filter.removal_witness (certificate.history n) candidate
  · exact hcurrent
  · rw [certificate.history_follows_filter n] at hremoved
    exact hremoved

theorem terminal_survivors_are_admissible {candidate : Candidate}
    (h : candidate ∈ certificate.survivors) :
    Admissible candidate :=
  certificate.terminal_survivors_admissible h

theorem terminal_landscape_is_stable :
    certificate.filter.retain certificate.survivors = certificate.survivors :=
  certificate.terminal_is_stable

theorem unresolved_residuals_remain_represented (residual : Residual)
    (hunresolved : Unresolved residual) :
    Represented residual certificate.survivors :=
  certificate.residuals_preserved residual hunresolved

/-- The terminal survivor set is the output of the declared filtration history,
not the result of an unrecorded post-processing step. -/
theorem terminal_survivors_follow_declared_filter :
    certificate.survivors =
      certificate.filter.stage certificate.initial certificate.terminalIndex := by
  rw [certificate.survivors_are_terminal, certificate.history_eq_stage]

end AccountableClosureCertificate

/-- A selection is a separate certificate layered on top of a survivor set. -/
structure ExternalWinnerSelection {Candidate : Type u}
    (survivors : Finset Candidate) where
  winner : Candidate
  winner_survives : winner ∈ survivors

/-- Plural closure leaves multiple admissible candidates; a winner can only be
named by supplying a separate selection certificate. -/
theorem plural_survivors_do_not_define_a_unique_winner
    {Candidate : Type u} (survivors : Finset Candidate)
    (hplural : ∃ first ∈ survivors, ∃ second ∈ survivors, first ≠ second) :
    ¬ ∃ winner, survivors = {winner} := by
  intro hsingleton
  rcases hplural with ⟨first, hfirst, second, hsecond, hne⟩
  rcases hsingleton with ⟨winner, hsurvivors⟩
  rw [hsurvivors] at hfirst hsecond
  simp only [Finset.mem_singleton] at hfirst hsecond
  exact hne (hfirst.trans hsecond.symm)

end ICG
