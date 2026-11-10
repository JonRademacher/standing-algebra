from __future__ import annotations
from pathlib import Path
import hashlib, json, os, platform, subprocess, sys, time

def sha256(path: Path) -> str:
    h=hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda:f.read(1024*1024), b""): h.update(chunk)
    return h.hexdigest()

def environment() -> dict:
    return {"python":sys.version, "platform":platform.platform(), "executable":sys.executable, "timestamp":time.time()}

def write_manifest(root: str | Path) -> Path:
    root=Path(root)
    entries=[]
    for path in sorted(p for p in root.rglob("*") if p.is_file() and p.name != "MANIFEST.sha256"):
        entries.append({"path":str(path.relative_to(root)), "sha256":sha256(path), "bytes":path.stat().st_size})
    target=root/"MANIFEST.sha256"
    target.write_text("\n".join(f'{x["sha256"]}  {x["path"]}' for x in entries)+"\n", encoding="utf-8")
    return target
