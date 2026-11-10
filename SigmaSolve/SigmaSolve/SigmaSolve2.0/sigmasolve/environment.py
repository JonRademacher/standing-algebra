from __future__ import annotations
from dataclasses import dataclass, asdict
from pathlib import Path
import json, shutil, subprocess

@dataclass
class Capability:
    name: str
    available: bool
    executable: str | None = None
    version: str | None = None
    detail: str = ""

def _command(name: str, version_args=("--version",)) -> Capability:
    exe=shutil.which(name)
    if not exe: return Capability(name,False,detail=f"{name} not found on PATH")
    try:
        p=subprocess.run([exe,*version_args],capture_output=True,text=True,timeout=15)
        version=(p.stdout or p.stderr).strip().splitlines()[0] if (p.stdout or p.stderr).strip() else "unknown"
        return Capability(name,p.returncode==0,exe,version)
    except Exception as e: return Capability(name,False,exe,detail=str(e))

def doctor() -> dict:
    caps={x.name:asdict(x) for x in [_command("lake"),_command("lean"),_command("docker"),_command("z3",("-version",))]}
    for module in ("sympy","mpmath","z3"):
        try:
            m=__import__(module); caps[module]={"name":module,"available":True,"version":getattr(m,"__version__","unknown"),"detail":"python module"}
        except Exception as e: caps[module]={"name":module,"available":False,"version":None,"detail":str(e)}
    return {"capabilities":caps,"lean_ready":caps["lake"]["available"] or caps["lean"]["available"],"research_ready":caps["sympy"]["available"] and caps["mpmath"]["available"]}

def write_doctor(path: str|Path) -> dict:
    report=doctor(); Path(path).write_text(json.dumps(report,indent=2),encoding="utf-8"); return report
