"""
Closure-Theoretic AI Policy Kernel
=================================

Author: Jon Rademacher
Contact: jonathan.d.rademacher [at] gmail.com
Year: 2026

This file implements a minimal, closure-theoretic policy layer
for constraining AI proposals against domination.

The kernel is a direct executable instantiation of a closure system
(S, C) (a Moore family), enforcing admissibility by canonical closure.

---------------------------------------------------------------
USAGE AND ATTRIBUTION TERMS
---------------------------------------------------------------

This code may be used, modified, and redistributed for academic,
research, safety, governance, or production purposes PROVIDED THAT:

1. Attribution to "Jon Rademacher" is clearly retained in:
   - source code,
   - documentation,
   - published descriptions,
   - or public deployments.

2. If used in a public system, paper, product, or service,
   explicit attribution must be provided as:

   "This system uses a closure-theoretic policy kernel
    by Jon Rademacher (2026)."

3. This code MAY NOT be presented as anonymous, proprietary,
   or rebranded work without attribution.

4. No warranty is provided; this software is supplied "AS IS".

---------------------------------------------------------------
LICENSE INTENT
---------------------------------------------------------------

This license is functionally equivalent to a permissive
attribution-required license (CC-BY-style intent), specialized
for executable policy kernels.

---------------------------------------------------------------
"""

from typing import Set, FrozenSet, Iterable


class ClosurePolicyKernel:
    """
    Closure-Theoretic Policy Kernel

    This kernel enforces non-domination by replacing any proposed
    set of actions, effects, or states with its least admissible
    closure under a declared closure system.

    It does not:
      - optimize
      - rank
      - predict
      - plan
      - learn
      - compare utilities

    It ONLY applies closure.
    """

    def init(self, universe: Set, closed_sets: Set[FrozenSet]):
        """
        Parameters
        ----------
        universe : Set
            The set S of all possible states/effects.

        closed_sets : Set[FrozenSet]
            The closure system C (a Moore family), assumed to be:
              - non-empty,
              - closed under arbitrary intersections,
              - containing the universe itself.

        Once constructed, the closure system is immutable.
        """

        self.S = frozenset(universe)
        self.C = frozenset(closed_sets)

        if self.S not in self.C:
            raise ValueError("Universe must be a member of the closure system.")

    # -------------------------
    # Core Closure Semantics
    # -------------------------

    def closure(self, X: Iterable) -> FrozenSet:
        """
        Compute the canonical closure Cl(X).

        Cl(X) = ⋂ { C ∈ C | X ⊆ C }

        This is the ONLY enforcement operation performed by the kernel.
        """
        X = frozenset(X)

        supersets = [C for C in self.C if X.issubset(C)]
        if not supersets:
            raise ValueError("No admissible closure exists for proposal.")

        return frozenset.intersection(*supersets)

    def interact(self, x, y) -> FrozenSet:
        """
        Interaction (composition):

        x ⊗ y = Cl({x, y})
        """
        return self.closure({x, y})

    # -------------------------
    # Specialization Preorder
    # -------------------------

    def neighborhood_filter(self, x) -> Set"""
        Fx = { C ∈ C | x ∈ C }

        Principal closure filter for x.
        """
        return {C for C in self.C if x in C}

    def dominates(self, x, y) -> bool:
        """
        Specialization preorder:

        x ⪯ y  ⇔  Fy ⊆ Fx

        Interpretable as:
        y is at least as constrained as x.
        """
        return self.neighborhood_filter(y).issubset(
            self.neighborhood_filter(x)
        )

    # -------------------------
    # Policy Firewall Interface
    # -------------------------

    def enforce(self, proposal: Iterable) -> FrozenSet:
        """
        Policy enforcement entrypoint.

        Any AI proposal MUST be passed here.

        The proposal is NEVER executed directly;
        it is replaced by its closure.
        """
        return self.closure(proposal)
