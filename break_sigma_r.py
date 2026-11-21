#!/usr/bin/env python3
"""Adversarial property breaker for Sigma-R v12. Standard library only; executes no candidate payloads."""
from __future__ import annotations
import argparse, importlib.util, json, random, sys, traceback
from dataclasses import asdict
from pathlib import Path

def load_core(root: Path):
    p = root if root.is_file() else (root/'Sigma-R-v12.py' if (root/'Sigma-R-v12.py').exists() else root/'sigma_r.py')
    spec=importlib.util.spec_from_file_location('sigma_r_break_target',p)
    m=importlib.util.module_from_spec(spec); sys.modules[spec.name]=m; spec.loader.exec_module(m)
    return m,p

def norm(z):
    d=z['adapter_decision']
    return (d.code,z['execution_boundary'],len(z['complete_survivors']),z.get('blocked_reason'))

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('target',nargs='?',default='.')
    ap.add_argument('--seed',type=int,default=1337)
    ap.add_argument('--cases',type=int,default=5000)
    ap.add_argument('--json-out',default='break-report.json')
    a=ap.parse_args(); rng=random.Random(a.seed)
    m,core=load_core(Path(a.target).resolve())
    fw=m.StructuredConsequenceFirewall(40); rr=m.AdapterAwareRepairReplay(fw)
    findings=[]; tested=0
    def fail(kind,case,detail): findings.append({'kind':kind,'case':case,'detail':detail})
    if hasattr(rr,'execute'): fail('executor_exposure',{},'AdapterAwareRepairReplay exposes execute')

    weird=['','prod','production','canary','global','LOCAL','x'*2048,'0.0.0.0/0','cluster-admin',None,True,False,0,[] ,{}]
    kinds=['Pod','Service','Deployment','Role','RoleBinding','ClusterRole','ClusterRoleBinding','Unknown','',None]
    for i in range(a.cases):
        family=rng.choice(['k8s','tf'])
        try:
            if family=='k8s':
                obj={'apiVersion':'v1','metadata':{'name':str(rng.choice(weird)),'namespace':str(rng.choice(weird))}}
                if rng.random()>.18: obj['kind']=rng.choice(kinds)
                if rng.random()>.25:
                    obj['spec']={'type':rng.choice(['ClusterIP','LoadBalancer','NodePort',None]),
                                 'loadBalancerSourceRanges':rng.choice([[],['0.0.0.0/0'],['10.0.0.0/24']]),
                                 'hostNetwork':rng.choice([True,False]),
                                 'containers':[{'securityContext':{'privileged':rng.choice([True,False])}}]}
                adapter=m.KubernetesManifestAdapter()
            else:
                change={}
                if rng.random()>.18: change['actions']=rng.choice([['create'],['update'],['delete'],['delete','create'],[],None])
                if rng.random()>.15: change['before']={}
                if rng.random()>.15: change['after']={'name':rng.choice(weird),'cidr_blocks':rng.choice([[],['0.0.0.0/0']])}
                obj={'resource_changes':[{'address':str(rng.choice(weird)),'type':rng.choice(['aws_instance','aws_iam_role','aws_security_group','docker_container',None]),'change':change}]}
                adapter=m.TerraformPlanAdapter()
            fs=adapter.adapt(obj)
            for f in fs:
                tested+=1
                z=rr.replay(f); got=norm(z)
                # Determinism check
                got2=norm(rr.replay(f))
                if got!=got2: fail('nondeterminism',obj,{'first':got,'second':got2})
                if z['execution_boundary']!='NOT_CROSSED': fail('boundary_crossing',obj,got)
                if f.residuals and z['adapter_decision'].code!=m.ADAPTER_INCOMPLETE:
                    fail('incomplete_fail_open',obj,{'residuals':list(f.residuals),'decision':z['adapter_decision'].code})
        except Exception as e:
            fail('crash',obj if 'obj' in locals() else {'iteration':i},{'exception':repr(e),'traceback':traceback.format_exc(limit=8)})

    # Direct typed invariants that adapters need not naturally emit.
    typed=[
      ('missing_evidence',m.StructuredProposal('terraform','plan','canary','local',evidence=False)),
      ('missing_authority',m.StructuredProposal('terraform','plan','canary','local',authorized=False)),
      ('protection_bypass',m.StructuredProposal('kubernetes','apply','canary','local',protection_bypass=True)),
    ]
    tr=m.StructuredRepairReplay(fw)
    for name,p in typed:
        tested+=1
        try:
            z=tr.replay(p)
            if z['complete_survivors']: fail(name+'_repair',asdict(p),{'survivors':len(z['complete_survivors'])})
            if z['execution_boundary']!='NOT_CROSSED': fail('boundary_crossing',asdict(p),z['execution_boundary'])
        except Exception as e: fail('typed_crash',asdict(p),repr(e))

    report={'tool':'Sigma-R adversarial breaker','seed':a.seed,'requested_cases':a.cases,'evaluated_findings':tested,'core':str(core),'violations':len(findings),'status':'BREAK_FOUND' if findings else 'NO_BREAK_FOUND','findings':findings[:100], 'findings_truncated':len(findings)>100,
            'interpretation':'NO_BREAK_FOUND is not proof of safety; it means no declared invariant violation was observed in this bounded run.'}
    Path(a.json_out).write_text(json.dumps(report,indent=2,default=str)+'\n')
    print(f"{report['status']}: {len(findings)} violation(s), {tested} finding(s) evaluated, seed={a.seed}")
    if findings: print('First:',json.dumps(findings[0],default=str)[:1000])
    print('Report:',a.json_out)
    return 1 if findings else 0
if __name__=='__main__': raise SystemExit(main())
