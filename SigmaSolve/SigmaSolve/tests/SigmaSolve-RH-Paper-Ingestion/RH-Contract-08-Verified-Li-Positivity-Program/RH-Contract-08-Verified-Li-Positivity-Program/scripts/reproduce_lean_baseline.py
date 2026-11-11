from pathlib import Path
import argparse, hashlib, json, shutil, subprocess, sys

def run(cmd,cwd=None):
    p=subprocess.run(cmd,cwd=cwd,text=True,capture_output=True)
    if p.returncode: print(p.stdout);print(p.stderr,file=sys.stderr);raise SystemExit(p.returncode)
    return p.stdout+p.stderr

def main():
    ap=argparse.ArgumentParser();ap.add_argument("--repo-url",required=True);ap.add_argument("--commit",required=True);ap.add_argument("--workdir",required=True);ns=ap.parse_args()
    if ns.commit in {"main","master","HEAD","PIN_EXACT_COMMIT",""}:raise SystemExit("Refusing unpinned commit")
    if not shutil.which("git") or not shutil.which("lake"):raise SystemExit("git and lake are required")
    wd=Path(ns.workdir).resolve();shutil.rmtree(wd,ignore_errors=True);wd.mkdir(parents=True)
    run(["git","clone","--no-checkout",ns.repo_url,"source"],wd);src=wd/"source";run(["git","checkout",ns.commit],src)
    log=run(["lake","build"],src);(wd/"lake-build.log").write_text(log)
    scan=run([sys.executable,str(Path(__file__).with_name("contract08.py")),"scan-lean",str(src)]);(wd/"source-scan.json").write_text(scan)
    files=[]
    for p in sorted(x for x in src.rglob("*") if x.is_file() and ".git" not in x.parts):files.append({"path":str(p.relative_to(src)),"sha256":hashlib.sha256(p.read_bytes()).hexdigest()})
    (wd/"manifest.json").write_text(json.dumps({"repo":ns.repo_url,"commit":ns.commit,"files":files},indent=2))
if __name__=="__main__":main()
