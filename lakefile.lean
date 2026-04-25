import Lake
open Lake DSL

package standing_algebra where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib StandingAlgebra where
  srcDir := "SigmaR"
