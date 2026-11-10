from pathlib import Path
import hashlib, sys
root=Path(__file__).resolve().parents[1]
manifest=root/"MANIFEST.sha256"
fail=[]
for line in manifest.read_text(encoding="utf-8").splitlines():
    digest, rel=line.split("  ",1)
    path=root/rel
    actual=hashlib.sha256(path.read_bytes()).hexdigest() if path.exists() else "MISSING"
    if actual!=digest: fail.append((rel,digest,actual))
if fail:
    print(*fail,sep="\n"); raise SystemExit(1)
print(f"Verified {len(manifest.read_text().splitlines())} files")
