from __future__ import annotations
import argparse, json
from pathlib import Path
from .agents import MockAgent, OpenAICompatibleAgent
from .models import ProblemContract
from .solver import SigmaSolver
from .benchmark import run_benchmark
from .environment import doctor, write_doctor
from .dependencies import LeanDependencyIndex
from .research import symbolic_check, z3_smt2, zeta_zero_scan, write_result
from .atomic_solver import AtomicClaimSolver, save_run
from .repair_probes import run_all
from .methodology import MethodologyKernel, load_contract, write_result as write_methodology_result

def _agent(args):
    if args.agent=="mock": return MockAgent()
    if not args.base_url or not args.model: raise SystemExit("--base-url and --model are required")
    return OpenAICompatibleAgent(args.base_url,args.model)

def main(argv=None):
    p=argparse.ArgumentParser(prog="sigmasolve")
    sub=p.add_subparsers(dest="command",required=True)
    for name in ("solve","benchmark"):
        x=sub.add_parser(name); x.add_argument("input"); x.add_argument("--agent",choices=["mock","openai-compatible"],default="mock"); x.add_argument("--base-url"); x.add_argument("--model"); x.add_argument("--output-root",default="sigmasolve-results"); x.add_argument("--no-verify",action="store_true")
    mk=sub.add_parser("methodology-review"); mk.add_argument("contract"); mk.add_argument("--output",default="methodology-result.json")
    a=sub.add_parser("atomic-solve"); a.add_argument("claims"); a.add_argument("--target",default="C007"); a.add_argument("--output",default="atomic-run.json")
    rp=sub.add_parser("repair-probes"); rp.add_argument("--output",default="repair-probes.json")
    d=sub.add_parser("doctor"); d.add_argument("--output")
    x=sub.add_parser("index"); x.add_argument("root"); x.add_argument("--output",default="dependency-index.json"); x.add_argument("--symbol")
    x=sub.add_parser("research"); x.add_argument("backend",choices=["symbolic","z3","zeta-scan"]); x.add_argument("payload"); x.add_argument("--end",type=float); x.add_argument("--steps",type=int,default=1000); x.add_argument("--output",default="research-result.json")
    args=p.parse_args(argv)
    if args.command=="methodology-review":
        result=MethodologyKernel().review(load_contract(args.contract)); write_methodology_result(result,args.output); print(json.dumps(result.__dict__,indent=2,default=str)); return
    if args.command=="atomic-solve":
        run=AtomicClaimSolver.load(args.claims).run(args.target); save_run(run,args.output); print(json.dumps(run.__dict__,indent=2)); return
    if args.command=="repair-probes":
        report=run_all(); Path(args.output).write_text(json.dumps(report,indent=2),encoding="utf-8"); print(json.dumps(report,indent=2)); return
    if args.command=="doctor":
        report=write_doctor(args.output) if args.output else doctor(); print(json.dumps(report,indent=2)); return
    if args.command=="index":
        idx=LeanDependencyIndex(args.root); report=idx.query(args.symbol) if args.symbol else idx.write(args.output); print(json.dumps(report,indent=2)); return
    if args.command=="research":
        if args.backend=="symbolic": result=symbolic_check(args.payload)
        elif args.backend=="z3": result=z3_smt2(Path(args.payload).read_text(encoding="utf-8"))
        else:
            if args.end is None: raise SystemExit("--end is required for zeta-scan")
            result=zeta_zero_scan(float(args.payload),args.end,args.steps)
        write_result(result,args.output); print(json.dumps(result.__dict__,indent=2)); return
    solver=SigmaSolver(_agent(args),output_root=args.output_root,verify=not args.no_verify)
    if args.command=="solve":
        result=solver.solve(ProblemContract.from_json(args.input)); print(json.dumps({"run_id":result.run_id,"status":result.status.value,"result_dir":result.result_dir,"summary":result.summary},indent=2))
    else:
        report=run_benchmark(args.input,solver); out=Path(args.output_root)/"benchmark-summary.json"; out.parent.mkdir(parents=True,exist_ok=True); out.write_text(json.dumps(report,indent=2),encoding="utf-8"); print(json.dumps(report,indent=2))

if __name__=="__main__": main()
