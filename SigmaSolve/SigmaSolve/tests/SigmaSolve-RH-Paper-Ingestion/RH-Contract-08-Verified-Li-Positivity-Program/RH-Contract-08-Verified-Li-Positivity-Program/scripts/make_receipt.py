from pathlib import Path
import argparse,hashlib,json,time
ap=argparse.ArgumentParser();ap.add_argument("root");ap.add_argument("--output",default="receipt.json");ns=ap.parse_args();r=Path(ns.root)
files=[]
for p in sorted(x for x in r.rglob("*") if x.is_file() and x.name!=Path(ns.output).name):files.append({"path":str(p.relative_to(r)),"bytes":p.stat().st_size,"sha256":hashlib.sha256(p.read_bytes()).hexdigest()})
Path(ns.output).write_text(json.dumps({"root":str(r),"generated":time.time(),"files":files},indent=2))
