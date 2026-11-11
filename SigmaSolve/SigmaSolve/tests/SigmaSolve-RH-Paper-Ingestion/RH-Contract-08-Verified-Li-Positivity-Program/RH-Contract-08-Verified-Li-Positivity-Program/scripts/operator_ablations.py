import json
try:
 import numpy as np
except Exception as e:
 print(json.dumps({"status":"SKIPPED","reason":str(e)}));raise SystemExit(0)
A=np.array([[1.0,.8],[.8,1.0]]);P=np.array([[1.0,0],[0,0]]);AP=A@P;PAP=P@A@P;cross=(np.eye(2)-P)@A@P
result={"A_positive":bool(np.all(np.linalg.eigvalsh(A)>=-1e-12)),"AP_self_adjoint":bool(np.allclose(AP,AP.T)),"PAP_positive":bool(np.all(np.linalg.eigvalsh(PAP)>=-1e-12)),"cross_trace":float(np.trace(cross)),"lesson":"one-sided product needs separate cross-term analysis"}
print(json.dumps(result,indent=2))
