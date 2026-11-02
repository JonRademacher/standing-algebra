module

public import ICG.ObstructionGeometry

@[expose] public section

namespace ICG

namespace InformationExample

/-- A small interaction system with two distinct finite histories for the same
terminal constraint. -/
def rules : InteractionSystem Nat where
  interacts _ _ output := output = 2

def seeds : Set Nat := {n | n ≤ 2}

def directHistory : DerivationTree rules seeds 2 :=
  .seed (by change 2 ≤ 2; exact le_rfl)

def interactionHistory : DerivationTree rules seeds 2 :=
  DerivationTree.interact (a := 0) (b := 1)
    (.seed (by change 0 ≤ 2; exact Nat.zero_le 2))
    (.seed (by change 1 ≤ 2; exact Nat.le_succ 1)) rfl

theorem histories_are_distinct : directHistory ≠ interactionHistory := by
  intro h
  cases h

/-- The root-only observation intentionally forgets the derivation history. -/
def observedResult {constraint : Nat} (_ : DerivationTree rules seeds constraint) : Nat :=
  constraint

theorem histories_have_same_observed_result :
    observedResult directHistory = observedResult interactionHistory := rfl

theorem histories_retain_distinct_ancestry :
    directHistory.nodes ≠ interactionHistory.nodes := by
  simp [directHistory, interactionHistory, DerivationTree.nodes]

end InformationExample

/-- A derivation certificate retains the full tree rather than only its conclusion. -/
structure DerivationCertificate {Constraint : Type*}
    (rules : InteractionSystem Constraint) (seeds : Set Constraint)
    (conclusion : Constraint) where
  tree : DerivationTree rules seeds conclusion

namespace DerivationCertificate

variable {Constraint : Type*} {rules : InteractionSystem Constraint}
  {seeds : Set Constraint} {conclusion : Constraint}

def conclusionOf (_ : DerivationCertificate rules seeds conclusion) : Constraint :=
  conclusion

def ancestry (certificate : DerivationCertificate rules seeds conclusion) :
    List Constraint :=
  certificate.tree.nodes

theorem conclusion_is_root (certificate : DerivationCertificate rules seeds conclusion) :
    conclusion ∈ certificate.ancestry :=
  certificate.tree.root_mem_nodes

theorem ancestry_leaves_are_seeds
    (certificate : DerivationCertificate rules seeds conclusion) {leaf : Constraint}
    (hleaf : leaf ∈ certificate.tree.leaves) :
    leaf ∈ seeds :=
  certificate.tree.leaves_mem_seeds hleaf

end DerivationCertificate

end ICG
