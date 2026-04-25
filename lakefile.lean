import Lake
open Lake DSL

/--
Standing Algebra (Σᴿ)

This lakefile defines only the package configuration.
All theory code, proofs, countermodels, and demonstrations
must live in ordinary `.lean` files under the source tree.
-/
package standing_algebra where
  -- Optional: set default Lean options here
  -- leanOptions := #[
  --   ⟨`autoImplicit, false⟩
  -- ]

/--
Mathlib dependency.
Pin the version if you want absolute reproducibility.
-/
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

/--
Core Standing Algebra library.

This should correspond to the folder:
  SigmaR/
    Core/
    Valuation/
    Operations/
    Regimes/
    Independence/
etc.
-/
@[defaultTarget]
lean_lib SigmaR
