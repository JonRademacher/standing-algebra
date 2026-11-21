#!/usr/bin/env python3
"""Sigma-R v12 external evaluator. Stdlib only. Does not execute candidate payloads."""
from __future__ import annotations
import argparse, hashlib, importlib.util, json, subprocess, sys, tempfile
from pathlib import Path

TEST_MODULES=[f"test_sigma_r_v{i}.py" for i in range(4,13)]

def sha256(p: Path)->str:
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()

def load_core(path: Path):
    spec=importlib.util.spec_from_file_location('sigma_r_external',path)
    m=importlib.util.module_from_spec(spec); sys.modules[spec.name]=m; spec.loader.exec_module(m)
    return m

def run_tests(root: Path):
    present=[x for x in TEST_MODULES if (root/x).exists()]
    if not present: return {'status':'NOT_PRESENT','modules':[]}
    cp=subprocess.run([sys.executable,'-m','unittest','-v',*present],cwd=root,text=True,capture_output=True,timeout=60)
    return {'status':'PASS' if cp.returncode==0 else 'FAIL','modules':present,'returncode':cp.returncode,'stdout':cp.stdout,'stderr':cp.stderr}

def behavioral(core):
    fw=core.StructuredConsequenceFirewall(40); rr=core.AdapterAwareRepairReplay(fw)
    cases=[]
    def add(name,finding,expect):
        z=rr.replay(finding); got=z['adapter_decision'].code
        cases.append({'name':name,'expected':expect,'got':got,'pass':got==expect,'boundary':z['execution_boundary'],'survivors':len(z['complete_survivors'])})
    add('k8s_missing_kind',core.KubernetesManifestAdapter().adapt({'apiVersion':'v1','metadata':{'name':'x'}})[0],core.ADAPTER_INCOMPLETE)
    add('terraform_missing_actions',core.TerraformPlanAdapter().adapt({'resource_changes':[{'address':'x','type':'aws_instance','change':{'before':{},'after':{}}}]})[0],core.ADAPTER_INCOMPLETE)
    add('privileged_pod',core.KubernetesManifestAdapter().adapt({'apiVersion':'v1','kind':'Pod','metadata':{'name':'x','namespace':'canary'},'spec':{'containers':[{'securityContext':{'privileged':True}}]}})[0],core.DOMINATION_BLOCK)
    svc=core.KubernetesManifestAdapter().adapt({'apiVersion':'v1','kind':'Service','metadata':{'name':'web','namespace':'production'},'spec':{'type':'LoadBalancer'}})[0]
    z=rr.replay(svc); cases.append({'name':'complete_input_repair','expected':'not ADAPTER_INCOMPLETE + survivor','got':z['adapter_decision'].code,'pass':z['adapter_decision'].code!=core.ADAPTER_INCOMPLETE and bool(z['complete_survivors']),'boundary':z['execution_boundary'],'survivors':len(z['complete_survivors'])})
    return {'status':'PASS' if all(c['pass'] and c['boundary']=='NOT_CROSSED' for c in cases) else 'FAIL','cases':cases}

def main():
    ap=argparse.ArgumentParser(description='Brutally simple independent evaluator for Sigma-R v12')
    ap.add_argument('target',nargs='?',default='.',help='wrapper directory or Sigma-R-v12.py')
    ap.add_argument('--expected-sha256',help='optional expected SHA-256 for standalone core')
    ap.add_argument('--json-out',default='external-evaluation.json')
    a=ap.parse_args(); target=Path(a.target).resolve()
    root=target if target.is_dir() else target.parent
    core=target if target.is_file() else (root/'Sigma-R-v12.py' if (root/'Sigma-R-v12.py').exists() else root/'sigma_r.py')
    report={'target':str(target),'core':str(core),'core_sha256':sha256(core)}
    report['hash_status']='PASS' if not a.expected_sha256 or report['core_sha256']==a.expected_sha256.lower() else 'FAIL'
    m=load_core(core); report['behavioral']=behavioral(m); report['regression']=run_tests(root)
    report['execution_surface_present']=hasattr(m.AdapterAwareRepairReplay(m.StructuredConsequenceFirewall()),'execute')
    report['overall']='PASS' if report['hash_status']=='PASS' and report['behavioral']['status']=='PASS' and report['regression']['status'] in ('PASS','NOT_PRESENT') and not report['execution_surface_present'] else 'FAIL'
    Path(a.json_out).write_text(json.dumps(report,indent=2)+'\n')
    print('Sigma-R external evaluation:',report['overall'])
    print(' core SHA-256:',report['core_sha256'])
    print(' behavioral:',report['behavioral']['status'])
    print(' regression:',report['regression']['status'])
    print(' execution surface:', 'FOUND' if report['execution_surface_present'] else 'none')
    print(' report:',a.json_out)
    return 0 if report['overall']=='PASS' else 1
if __name__=='__main__': raise SystemExit(main())
