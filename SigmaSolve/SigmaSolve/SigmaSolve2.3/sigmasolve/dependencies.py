from __future__ import annotations
from pathlib import Path
import re, json

DECL=re.compile(r"^\s*(?:theorem|lemma|def|structure|class|instance|abbrev)\s+([A-Za-z0-9_'.]+)",re.M)
IMPORT=re.compile(r"^\s*import\s+(.+)$",re.M)
TOKEN=re.compile(r"\b[A-Za-z_][A-Za-z0-9_'.]*\b")

class LeanDependencyIndex:
    def __init__(self, root: str|Path): self.root=Path(root)
    def build(self) -> dict:
        files=[]; declarations={}; imports={}
        for p in sorted(self.root.rglob("*.lean")):
            if any(x in p.parts for x in (".lake","build")): continue
            text=p.read_text(encoding="utf-8",errors="ignore"); rel=str(p.relative_to(self.root))
            files.append(rel); imports[rel]=IMPORT.findall(text)
            for name in DECL.findall(text): declarations.setdefault(name,[]).append(rel)
        return {"root":str(self.root),"files":files,"declarations":declarations,"imports":imports}
    def query(self, symbol: str) -> dict:
        idx=self.build(); exact=idx["declarations"].get(symbol,[])
        related={k:v for k,v in idx["declarations"].items() if symbol.lower() in k.lower() and k!=symbol}
        return {"symbol":symbol,"exact":exact,"related":related}
    def write(self,path:str|Path)->dict:
        x=self.build(); Path(path).write_text(json.dumps(x,indent=2,sort_keys=True),encoding="utf-8"); return x
