from __future__ import annotations
import dataclasses, hashlib, hmac, json, math, re, secrets, threading, time, uuid
from collections import deque
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import Any, Callable, Deque, Iterable, Mapping, Optional, Protocol, Sequence

JsonMap=Mapping[str,Any]

def _unit(v:Any,n:str)->float:
    try: x=float(v)
    except Exception as e: raise ValueError(f"{n} must be numeric") from e
    if not math.isfinite(x) or not 0<=x<=1: raise ValueError(f"{n} must be in [0,1]")
    return x

def _safe(v:Any)->Any:
    if dataclasses.is_dataclass(v): return _safe(dataclasses.asdict(v))
    if isinstance(v,Enum): return v.value
    if isinstance(v,Mapping): return {str(k):_safe(x) for k,x in v.items()}
    if isinstance(v,(list,tuple,set,deque)): return [_safe(x) for x in v]
    if isinstance(v,(str,int,float,bool)) or v is None: return v
    return repr(v)

def _canon(v:Any)->str: return json.dumps(_safe(v),sort_keys=True,separators=(",",":"),ensure_ascii=False)
def _sha(v:Any)->str: return hashlib.sha256((v if isinstance(v,bytes) else str(v).encode())).hexdigest()
def _utc()->str: return time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime())

class Decision(str,Enum):
    ALLOW="ALLOW"; PROJECT="PROJECT"; ABSTAIN="ABSTAIN"; ADAPTER_FAIL="ADAPTER_FAIL"; EVIDENCE_BLOCK="EVIDENCE_BLOCK"; AUTHORITY_BLOCK="AUTHORITY_BLOCK"; DOMINATION_BLOCK="DOMINATION_BLOCK"; POLICY_BLOCK="POLICY_BLOCK"; EMERGENCY_G="EMERGENCY_G"; EVALUATOR_FAIL="EVALUATOR_FAIL"; CIRCUIT_OPEN="CIRCUIT_OPEN"; RATE_LIMIT="RATE_LIMIT"
class RuleEffect(str,Enum): BLOCK="BLOCK"; PROJECT="PROJECT"; FLAG="FLAG"

@dataclass(frozen=True)
class Rule:
    rule_id:str; description:str; pattern:str; effect:RuleEffect=RuleEffect.BLOCK; replacement:str="[REDACTED]"; flags:int=re.I|re.S
    def apply(self,text:str)->tuple[bool,str]:
        hit=bool(re.search(self.pattern,text,self.flags)); return hit,(re.sub(self.pattern,self.replacement,text,flags=self.flags) if hit and self.effect==RuleEffect.PROJECT else text)

@dataclass(frozen=True)
class SigmaRPolicy:
    policy_id:str="sigma-r-production-v1"; required_context_keys:tuple[str,...]=("sources",); require_nonempty_sources:bool=True
    authority_key:str="user_authorized"; action_key:str="consequential_action"; max_hallucination_risk:float=.20; max_coercion_risk:float=.10; max_action_risk:float=.10
    max_output_chars:int=200000; max_requests_per_minute:int=600; circuit_failure_threshold:int=8; circuit_reset_seconds:int=30; history_limit:int=2000
    fail_closed:bool=True; allow_projection:bool=True; receipt_hmac_env:str="SIGMA_R_RECEIPT_KEY"; abstention_text:str="Unable to realize this proposal within the declared evidence, authority, and admissibility constraints."
    emergency_text:str="The declared constraints are mutually incompatible. No consequential action was taken."
    rules:tuple[Rule,...]=field(default_factory=lambda:(
        Rule("override","Blocks claimed authority override",r"\b(ignore|bypass|disable|override)\b.{0,60}\b(policy|guardrail|authorization|approval|safety)\b"),
        Rule("coercion","Blocks explicit coercion",r"\b(you have no choice|must obey|do not question|must accept)\b"),
        Rule("secret","Redacts common credential assignments",r"\b(api[_-]?key|token|password|secret)\s*[:=]\s*['\"]?[^\s'\"]+",RuleEffect.PROJECT,"[REDACTED_CREDENTIAL]"),
    ))
    def __post_init__(self):
        for n in ("max_hallucination_risk","max_coercion_risk","max_action_risk"): _unit(getattr(self,n),n)
        for n in ("max_output_chars","max_requests_per_minute","circuit_failure_threshold","circuit_reset_seconds","history_limit"):
            if getattr(self,n)<1: raise ValueError(f"{n} must be positive")
    @classmethod
    def from_dict(cls,d:Mapping[str,Any])->"SigmaRPolicy":
        x=dict(d)
        if "required_context_keys" in x: x["required_context_keys"]=tuple(x["required_context_keys"])
        if "rules" in x: x["rules"]=tuple(Rule(**{**r,"effect":RuleEffect(r.get("effect","BLOCK"))}) for r in x["rules"])
        return cls(**x)

@dataclass(frozen=True)
class GuardRequest:
    text:str; context:JsonMap=field(default_factory=dict); metadata:JsonMap=field(default_factory=dict); request_id:str=field(default_factory=lambda:str(uuid.uuid4()))
@dataclass(frozen=True)
class RiskAssessment:
    hallucination_risk:float=0; coercion_risk:float=0; action_risk:float=0; evidence_complete:bool=True; claims_override:bool=False; minimum_required_risk:float=0; reasons:tuple[str,...]=(); projected_text:Optional[str]=None
    def __post_init__(self):
        for n in ("hallucination_risk","coercion_risk","action_risk","minimum_required_risk"): _unit(getattr(self,n),n)
@dataclass(frozen=True)
class GuardResult:
    request_id:str; decision:Decision; allowed:bool; output_text:str; original_sha256:str; output_sha256:str; reasons:tuple[str,...]; assessment:RiskAssessment; policy_id:str; receipt:Mapping[str,Any]; latency_ms:float
    def to_dict(self)->dict[str,Any]: return _safe(self)

class Evaluator(Protocol):
    def __call__(self,text:str,context:JsonMap,metadata:JsonMap)->RiskAssessment:...

class MetadataEvaluator:
    """Conservative default. Production stacks should provide independent evidence, policy and deployment evaluators."""
    def __call__(self,text:str,context:JsonMap,metadata:JsonMap)->RiskAssessment:
        grounded=bool(context.get("sources")); gs=metadata.get("grounding_score")
        h=1-_unit(gs,"grounding_score") if gs is not None else (.1 if grounded else .9)
        return RiskAssessment(hallucination_risk=h,coercion_risk=_unit(metadata.get("coercion_risk",0),"coercion_risk"),action_risk=_unit(metadata.get("action_risk",.5 if metadata.get("consequential_action") else 0),"action_risk"),evidence_complete=bool(metadata.get("evidence_complete",grounded)),claims_override=bool(metadata.get("claims_override",False)),minimum_required_risk=_unit(metadata.get("minimum_required_risk",0),"minimum_required_risk"),reasons=tuple(metadata.get("reasons",())))

class RateLimiter:
    def __init__(self,limit:int): self.limit=limit; self.events:Deque[float]=deque(); self.lock=threading.Lock()
    def allow(self)->bool:
        now=time.monotonic()
        with self.lock:
            while self.events and now-self.events[0]>=60:self.events.popleft()
            if len(self.events)>=self.limit:return False
            self.events.append(now);return True
class CircuitBreaker:
    def __init__(self,threshold:int,reset:int): self.threshold=threshold; self.reset=reset; self.failures=0; self.opened=0.; self.lock=threading.Lock()
    def allow(self)->bool:
        with self.lock:
            if self.opened and time.monotonic()-self.opened<self.reset:return False
            if self.opened:self.opened=0;self.failures=0
            return True
    def success(self):
        with self.lock:self.failures=0
    def failure(self):
        with self.lock:
            self.failures+=1
            if self.failures>=self.threshold:self.opened=time.monotonic()

class AuditSink(Protocol):
    def write(self,event:Mapping[str,Any])->None:...
class JsonlAuditSink:
    def __init__(self,path:str|Path):self.path=Path(path);self.lock=threading.Lock()
    def write(self,event:Mapping[str,Any])->None:
        self.path.parent.mkdir(parents=True,exist_ok=True)
        with self.lock,self.path.open("a",encoding="utf-8") as f:f.write(_canon(event)+"\n")

class SigmaRFirewall:
    def __init__(self,policy:SigmaRPolicy|None=None,evaluators:Sequence[Evaluator]|None=None,audit_sink:AuditSink|None=None):
        self.policy=policy or SigmaRPolicy(); self.evaluators=tuple(evaluators or (MetadataEvaluator(),)); self.audit=audit_sink
        self.rate=RateLimiter(self.policy.max_requests_per_minute); self.circuit=CircuitBreaker(self.policy.circuit_failure_threshold,self.policy.circuit_reset_seconds)
        self.history:Deque[GuardResult]=deque(maxlen=self.policy.history_limit); self.lock=threading.RLock(); self.prev="0"*64
    def _receipt(self,req:GuardRequest,decision:Decision,out:str)->dict[str,Any]:
        core={"receipt_id":str(uuid.uuid4()),"timestamp_utc":_utc(),"request_id":req.request_id,"policy_id":self.policy.policy_id,"decision":decision.value,"input_sha256":_sha(req.text),"output_sha256":_sha(out),"context_sha256":_sha(_canon(req.context)),"metadata_sha256":_sha(_canon(req.metadata)),"previous_receipt_sha256":self.prev}
        body=_canon(core).encode()
        # Environment lookup kept local to avoid serializing secrets.
        import os
        key=os.getenv(self.policy.receipt_hmac_env)
        sig=hmac.new(key.encode(),body,hashlib.sha256).hexdigest() if key else None
        core["receipt_sha256"]=_sha(body);core["receipt_hmac_sha256"]=sig;self.prev=core["receipt_sha256"];return core
    def _finish(self,start:float,req:GuardRequest,d:Decision,ok:bool,out:str,reasons:Iterable[str],a:RiskAssessment)->GuardResult:
        r=GuardResult(req.request_id,d,ok,out,_sha(req.text),_sha(out),tuple(dict.fromkeys(reasons)),a,self.policy.policy_id,self._receipt(req,d,out),round((time.perf_counter()-start)*1000,3));self.history.append(r)
        if self.audit:self.audit.write(r.to_dict())
        return r
    def guard(self,req:GuardRequest)->GuardResult:
        start=time.perf_counter(); neutral=RiskAssessment(evidence_complete=False,reasons=("not evaluated",))
        with self.lock:
            if not self.rate.allow():return self._finish(start,req,Decision.RATE_LIMIT,False,self.policy.abstention_text,("rate limit exceeded",),neutral)
            if not self.circuit.allow():return self._finish(start,req,Decision.CIRCUIT_OPEN,False,self.policy.abstention_text,("circuit breaker open",),neutral)
            errors=[f"missing context: {k}" for k in self.policy.required_context_keys if k not in req.context]
            if self.policy.require_nonempty_sources and not req.context.get("sources"):errors.append("sources must be non-empty")
            if len(req.text)>self.policy.max_output_chars:errors.append("output exceeds configured maximum")
            if req.metadata.get(self.policy.action_key) and req.context.get(self.policy.authority_key) is not True:errors.append("consequential action lacks explicit authority")
            if errors:return self._finish(start,req,Decision.ADAPTER_FAIL,False,self.policy.abstention_text,errors,neutral)
            projected=req.text; flags=[]
            for rule in self.policy.rules:
                hit,candidate=rule.apply(projected)
                if not hit:continue
                flags.append(rule.rule_id)
                if rule.effect==RuleEffect.BLOCK:return self._finish(start,req,Decision.DOMINATION_BLOCK,False,self.policy.abstention_text,(rule.description,),neutral)
                if rule.effect==RuleEffect.PROJECT:projected=candidate
            try:
                vals=[e(projected,req.context,req.metadata) for e in self.evaluators]
                a=RiskAssessment(max(v.hallucination_risk for v in vals),max(v.coercion_risk for v in vals),max(v.action_risk for v in vals),all(v.evidence_complete for v in vals),any(v.claims_override for v in vals),max(v.minimum_required_risk for v in vals),tuple(dict.fromkeys(x for v in vals for x in v.reasons)),next((v.projected_text for v in vals if v.projected_text is not None),None))
                self.circuit.success()
            except Exception as e:
                self.circuit.failure(); ok=not self.policy.fail_closed
                return self._finish(start,req,Decision.EVALUATOR_FAIL,ok,req.text if ok else self.policy.abstention_text,(f"evaluator failure: {type(e).__name__}: {e}",),neutral)
            if a.claims_override:return self._finish(start,req,Decision.DOMINATION_BLOCK,False,self.policy.abstention_text,a.reasons+("authority override claimed",),a)
            if not a.evidence_complete:return self._finish(start,req,Decision.EVIDENCE_BLOCK,False,self.policy.abstention_text,a.reasons+("evidence incomplete",),a)
            if a.minimum_required_risk>self.policy.max_hallucination_risk:return self._finish(start,req,Decision.EMERGENCY_G,False,self.policy.emergency_text,a.reasons+("constraint envelope infeasible",),a)
            over=a.hallucination_risk>self.policy.max_hallucination_risk or a.coercion_risk>self.policy.max_coercion_risk or a.action_risk>self.policy.max_action_risk
            if over:
                candidate=a.projected_text
                if candidate is not None and self.policy.allow_projection:return self._finish(start,req,Decision.PROJECT,True,candidate,a.reasons+("evaluator projection applied",),a)
                return self._finish(start,req,Decision.ABSTAIN,False,self.policy.abstention_text,a.reasons+("risk exceeds admissible envelope",),a)
            if projected!=req.text:return self._finish(start,req,Decision.PROJECT,True,projected,tuple(flags),a)
            return self._finish(start,req,Decision.ALLOW,True,req.text,a.reasons,a)
    def guard_text(self,text:str,context:JsonMap|None=None,metadata:JsonMap|None=None)->GuardResult:return self.guard(GuardRequest(text,dict(context or {}),dict(metadata or {})))
    def health(self)->dict[str,Any]:return {"status":"ok" if self.circuit.allow() else "degraded","policy_id":self.policy.policy_id,"history_size":len(self.history)}

class CallableAdapter:
    def __init__(self,firewall:SigmaRFirewall,fn:Callable[...,Any],extractor:Callable[[Any],str]|None=None):self.firewall=firewall;self.fn=fn;self.extractor=extractor or extract_text
    def __call__(self,*args:Any,context:JsonMap|None=None,metadata:JsonMap|None=None,**kwargs:Any)->GuardResult:return self.firewall.guard_text(self.extractor(self.fn(*args,**kwargs)),context,metadata)

def extract_text(r:Any)->str:
    if isinstance(r,str):return r
    if isinstance(r,Mapping):
        for k in ("output_text","text","content","response"):
            if isinstance(r.get(k),str):return r[k]
        if r.get("choices"):return extract_text(r["choices"][0])
        if r.get("message") is not None:return extract_text(r["message"])
    for k in ("output_text","text","content"):
        v=getattr(r,k,None)
        if isinstance(v,str):return v
    if getattr(r,"choices",None):return extract_text(r.choices[0])
    if getattr(r,"message",None) is not None:return extract_text(r.message)
    raise TypeError("cannot extract response text; provide an extractor")

