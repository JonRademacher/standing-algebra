from __future__ import annotations
import argparse, json
from pathlib import Path
from .agents import MockAgent, OpenAICompatibleAgent
from .models import ProblemContract
from .solver import SigmaSolver
from .benchmark import run_benchmark

def _agent(args):
    if args.agent=="mock": return MockAgent()
    if not args.base_url or not args.model: raise SystemExit("--base-url and --model are required")
    return OpenAICompatibleAgent(args.base_url,args.model)

def main(argv=None):
    p=argparse.ArgumentParser(prog="sigmasolve")
    sub=p.add_subparsers(dest="command",required=True)
    for name in ("solve","benchmark"):
        x=sub.add_parser(name); x.add_argument("input"); x.add_argument("--agent",choices=["mock","openai-compatible"],default="mock"); x.add_argument("--base-url"); x.add_argument("--model"); x.add_argument("--output-root",default="sigmasolve-results"); x.add_argument("--no-verify",action="store_true")
    args=p.parse_args(argv); solver=SigmaSolver(_agent(args),output_root=args.output_root,verify=not args.no_verify)
    if args.command=="solve":
        result=solver.solve(ProblemContract.from_json(args.input)); print(json.dumps({"run_id":result.run_id,"status":result.status.value,"result_dir":result.result_dir,"summary":result.summary},indent=2))
    else:
        report=run_benchmark(args.input,solver); out=Path(args.output_root)/"benchmark-summary.json"; out.parent.mkdir(parents=True,exist_ok=True); out.write_text(json.dumps(report,indent=2),encoding="utf-8"); print(json.dumps(report,indent=2))

if __name__=="__main__": main()
