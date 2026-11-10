"""Finite-dimensional probes of operator logic only; not a model of zeta or the adelic spaces."""
import numpy as np

# Positive A and projection P. A@P need not be positive/self-adjoint.
A=np.array([[1.0,0.8],[0.8,1.0]])
P=np.array([[1.0,0.0],[0.0,0.0]])
AP=A@P
assert np.all(np.linalg.eigvalsh(A)>=-1e-12)
assert not np.allclose(AP,AP.T)

# The compressed operator P A P is positive.
PAP=P@A@P
assert np.all(np.linalg.eigvalsh(PAP)>=-1e-12)

# Exact trace decomposition used as an abstract analogue:
# tr(AP)=tr(PAP)+tr((I-P)AP)
I=np.eye(2)
assert abs(np.trace(AP)-np.trace(PAP)-np.trace((I-P)@A@P))<1e-12

print({
 "A_positive":True,
 "A_times_P_self_adjoint":bool(np.allclose(AP,AP.T)),
 "PAP_positive":True,
 "trace_AP":float(np.trace(AP)),
 "trace_PAP":float(np.trace(PAP)),
 "cross_trace":float(np.trace((I-P)@A@P)),
 "scope":"operator-logic probe only"
})
