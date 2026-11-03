module

public import Mathlib.Logic.Relation

@[expose] public section

namespace ICG

/-- A transition system whose elementary transitions stay in the admissible
region and can be reversed. Reversibility is an explicit hypothesis of the
reachability-equivalence result. -/
structure AdmissibleTransitionSystem (State : Type*) where
  admissible : State → Prop
  transition : State → State → Prop
  transition_preserves_admissibility :
    ∀ {source target}, transition source target →
      admissible source ∧ admissible target
  transition_reversible :
    ∀ {source target}, transition source target →
      transition target source

namespace AdmissibleTransitionSystem

variable {State : Type*} (system : AdmissibleTransitionSystem State)

/-- Reachability is existence of a finite chain of admissible transitions. -/
def Reachable (source target : State) : Prop :=
  Relation.ReflTransGen system.transition source target

theorem reachable_refl (state : State) : system.Reachable state state :=
  Relation.ReflTransGen.refl

theorem reachable_trans {source middle target : State}
    (first : system.Reachable source middle)
    (second : system.Reachable middle target) :
    system.Reachable source target :=
  Relation.ReflTransGen.trans first second

theorem reachable_symm {source target : State}
    (reachable : system.Reachable source target) :
    system.Reachable target source := by
  have hStepSymm : Std.Symm system.transition :=
    ⟨fun _ _ edge => system.transition_reversible edge⟩
  have hReachableSymm :
      Std.Symm (Relation.ReflTransGen system.transition) :=
    Relation.ReflTransGen.stdSymm
  exact hReachableSymm.symm source target reachable

/-- A reachable state from an admissible source is admissible, because every
elementary transition preserves the declared admissibility predicate. -/
theorem reachable_preserves_admissibility {source target : State}
    (reachable : system.Reachable source target)
    (source_admissible : system.admissible source) :
    system.admissible target := by
  rcases Relation.ReflTransGen.cases_tail reachable with hEq | ⟨_, _, edge⟩
  · simpa [hEq] using source_admissible
  · exact (system.transition_preserves_admissibility edge).2

/-- Finite admissible reachability is an equivalence relation. -/
theorem reachable_equivalence :
    Equivalence system.Reachable where
  refl := system.reachable_refl
  symm := @system.reachable_symm
  trans := @system.reachable_trans

/-- Reachability classes are represented by the quotient setoid associated
with the admissible transition relation. -/
def reachableSetoid : Setoid State where
  r := system.Reachable
  iseqv := system.reachable_equivalence

end AdmissibleTransitionSystem

end ICG
