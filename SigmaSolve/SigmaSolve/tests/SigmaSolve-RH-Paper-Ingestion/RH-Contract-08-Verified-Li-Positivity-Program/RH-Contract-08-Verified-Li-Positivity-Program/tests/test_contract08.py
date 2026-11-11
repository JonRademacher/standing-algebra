import json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).parents[1]
def test_registered_candidates_validate():
 for p in (ROOT/'candidates').glob('*.json'):
  q=subprocess.run([sys.executable,str(ROOT/'scripts/contract08.py'),'validate-candidate',str(p)],capture_output=True,text=True)
  assert q.returncode==0,(p,q.stdout,q.stderr)
def test_no_promotion_in_status():
 s=(ROOT/'STATUS.md').read_text();assert 'Universal positivity: `OPEN`' in s and 'Riemann Hypothesis: `OPEN`' in s
