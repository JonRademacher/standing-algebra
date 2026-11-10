from __future__ import annotations
from pathlib import Path
import sqlite3, json, time, hashlib

class TheoremMemory:
    def __init__(self,path:str|Path):
        self.path=Path(path); self.path.parent.mkdir(parents=True,exist_ok=True)
        self.db=sqlite3.connect(self.path)
        self.db.execute("""create table if not exists knowledge(
          id text primary key, kind text, statement text, payload text, evidence text,
          dependencies text, created real, verified integer)"""); self.db.commit()
    def add(self,kind,statement,payload,evidence,dependencies=(),verified=False):
        raw=json.dumps([kind,statement,payload,evidence,list(dependencies)],sort_keys=True)
        id=hashlib.sha256(raw.encode()).hexdigest()[:20]
        self.db.execute("insert or replace into knowledge values(?,?,?,?,?,?,?,?)",(id,kind,statement,json.dumps(payload),json.dumps(evidence),json.dumps(list(dependencies)),time.time(),int(verified))); self.db.commit(); return id
    def search(self,query,limit=20):
        q=f"%{query}%"; rows=self.db.execute("select id,kind,statement,payload,evidence,dependencies,verified from knowledge where statement like ? or payload like ? order by created desc limit ?",(q,q,limit)).fetchall()
        return [{"id":r[0],"kind":r[1],"statement":r[2],"payload":json.loads(r[3]),"evidence":json.loads(r[4]),"dependencies":json.loads(r[5]),"verified":bool(r[6])} for r in rows]
