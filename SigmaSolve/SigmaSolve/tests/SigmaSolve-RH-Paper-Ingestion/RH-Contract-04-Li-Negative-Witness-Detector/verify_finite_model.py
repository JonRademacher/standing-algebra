from pathlib import Path
import json
d=json.loads((Path(__file__).parent/"finite-model-scan.json").read_text())
assert d["first_negative"] is not None
assert d["first_negative"]["n"] <= 500
print(d["first_negative"])
