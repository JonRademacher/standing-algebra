import Lake
open Lake DSL

/--
Standing Algebra (Σᴿ)

Package configuration only.
No theory code belongs in this file.
-/
package standing_algebra where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib SigmaR
