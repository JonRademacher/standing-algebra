from __future__ import annotations
from pathlib import Path
import argparse, hashlib, json, re, sys

FORBIDDEN={"RiemannHypothesis","UniversalLiPositivity","AllZerosOnCriticalLine","WeilPositivityAssumed","N0EqN"}

def load(p): return json.loads(Path(p).read_text(encoding="utf-8"))
def sha256(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def validate_candidate(path):
    c=load(path); errors=[]
    for k in ("id","name","family","identity","positivity","independence","status"):
        if k not in c: errors.append(f"missing {k}")
    deps=set(c.get("identity",{}).get("dependencies",[])+c.get("positivity",{}).get("dependencies",[]))
    forbidden=set(c.get("independence",{}).get("forbidden_dependencies",[]))
    hidden=sorted(deps & (FORBIDDEN|forbidden))
    if hidden: errors.append("forbidden dependency path: "+", ".join(hidden))
    return {"candidate":c.get("id"),"valid_schema":not errors,"errors":errors,"sha256":sha256(path)}

def dependency_cycle(path):
    data=load(path); graph=data.get("graph",{}); seen=set(); stack=set(); cycles=[]
    def visit(n,trail):
        if n in stack: cycles.append(trail+[n]); return
        if n in seen:return
        stack.add(n)
        for m in graph.get(n,[]):visit(m,trail+[n])
        stack.remove(n);seen.add(n)
    for n in graph:visit(n,[])
    return {"cycles":cycles,"acyclic":not cycles}

def scan_source(root):
    hits=[]
    patterns=re.compile(r"\b(sorry|admit|axiom|unsafe)\b")
    for p in Path(root).rglob("*.lean"):
        for i,line in enumerate(p.read_text(errors="ignore").splitlines(),1):
            if patterns.search(line):hits.append({"file":str(p),"line":i,"text":line.strip()})
    return {"hits":hits,"pass":not hits}

def main():
    ap=argparse.ArgumentParser(); sub=ap.add_subparsers(dest="cmd",required=True)
    a=sub.add_parser("validate-candidate");a.add_argument("path")
    a=sub.add_parser("dependency-cycle");a.add_argument("path")
    a=sub.add_parser("scan-lean");a.add_argument("root")
    ns=ap.parse_args()
    r=validate_candidate(ns.path) if ns.cmd=="validate-candidate" else dependency_cycle(ns.path) if ns.cmd=="dependency-cycle" else scan_source(ns.root)
    print(json.dumps(r,indent=2)); raise SystemExit(0 if r.get("pass",r.get("valid_schema",r.get("acyclic",False))) else 1)
if __name__=="__main__":main()
