from itertools import product
from sigmasolve.rh_contracts import (
    ZeroOccurrence, BoundedZeroCertificate, global_iff_all_bounded
)

def test_count_geometry_exhaustive():
    checked = 0
    for n in range(7):
        for bits in product([False, True], repeat=n):
            for mults in product([1, 2, 3], repeat=n):
                c = BoundedZeroCertificate(10, [
                    ZeroOccurrence(i, float(i), m, b)
                    for i, (m, b) in enumerate(zip(mults, bits))
                ])
                assert c.count_laws()
                checked += 1
    assert checked > 10000

def test_bounded_global_bridge_exhaustive():
    atoms = [(i, h, b) for i, h in enumerate([-2, -1, 0, 1, 2]) for b in [False, True]]
    checked = 0
    for n in range(6):
        for picks in product(atoms, repeat=n):
            assert global_iff_all_bounded(picks)
            checked += 1
    assert checked == 111111

def test_window_guard():
    try:
        BoundedZeroCertificate(1, [ZeroOccurrence("x", 2, 1, True)])
    except ValueError:
        return
    assert False, "out-of-window occurrence should be rejected"
