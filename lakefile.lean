import Lake
open Lake DSL

package SigmaR

/--
The Σᴿ Lean 4 development.  The library is rooted at `SigmaR/`; the module
`SigmaR.lean` does not exist, so the globs are declared explicitly and every
submodule of the tree is built.
-/
@[default_target]
lean_lib SigmaR where
  globs := #[.submodules `SigmaR]

/--
The collapse and Goodhart-drift demonstrations, rooted at
`Collapse_Demonstrations/`.
-/
@[default_target]
lean_lib Collapse_Demonstrations where
  globs := #[.submodules `Collapse_Demonstrations]
