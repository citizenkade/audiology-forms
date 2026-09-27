#!/usr/bin/env python3
"""Copy data/ehdi-state-reference.json into ehdi-report.html's #state-reference block.

The JSON is the source. It's exported by Project research's bt_07f_ehdi_reference_export.py.
Rerun this after every export; never hand-edit the copy inside the form.
"""
import json, re, pathlib

root = pathlib.Path(__file__).resolve().parent.parent
data = json.loads((root / "data/ehdi-state-reference.json").read_text())
blob = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("<", "\\u003c")
form = root / "ehdi-report.html"
html = form.read_text()
pat = re.compile(r'(<script type="application/json" id="state-reference">)[\s\S]*?(</script>)')
if len(pat.findall(html)) != 1:
    raise SystemExit("expected exactly one state-reference block")
form.write_text(pat.sub(lambda m: m.group(1) + blob + m.group(2), html))
print(f"embedded {len(data['states'])} states, {len(blob):,} bytes")
