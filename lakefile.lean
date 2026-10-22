import Lake
open Lake DSL

package SigmaR

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

lean_lib SigmaR_Core

lean_lib SigmaR where
  globs := #[.submodules `SigmaR]

lean_lib Collapse_Demonstrations where
  globs := #[.submodules `Collapse_Demonstrations]

lean_lib ICG
