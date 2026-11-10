from __future__ import annotations
from pathlib import Path
import shutil, subprocess

def docker_available(): return bool(shutil.which("docker"))

def run_in_docker(problem:str,output:str,image="sigmasolve:0.2.0"):
    if not docker_available(): raise RuntimeError("Docker is unavailable")
    root=Path(problem).resolve().parent
    cmd=["docker","run","--rm","--network=none","--memory=6g","--cpus=4","-v",f"{root}:/work:ro","-v",f"{Path(output).resolve()}:/out",image,"sigmasolve","solve",f"/work/{Path(problem).name}","--output-root","/out"]
    return subprocess.run(cmd,capture_output=True,text=True,timeout=3600)
