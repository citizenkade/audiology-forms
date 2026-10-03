#!/bin/bash
# Rebuilds the README screenshots in docs/ehdi/ from a sample-filled copy of the form.
# Usage: bash scripts/readme-shots/ehdi.sh [work-dir]   (needs Google Chrome, poppler's pdftoppm, and Pillow)
# The work dir (default: a fresh temp dir) holds the sample form, the wrapper pages, and the raw PNGs.
set -e
REPO="$(cd "$(dirname "$0")/../.." && pwd)"
WORK="${1:-$(mktemp -d)}"
SP="$WORK"; mkdir -p $SP/shots && cat > $SP/sample.py <<'EOF'
import json, re, base64, pathlib, sys
ROOT=pathlib.Path(sys.argv[2]); OUT=pathlib.Path(sys.argv[1])
def embed(html,id_,obj):
    blob=json.dumps(obj).replace("<","\\u003c"); pat=re.compile(r'(<script type="application/json" id="%s">)[\s\S]*?(</script>)'%id_)
    assert len(pat.findall(html))==1; return pat.sub(lambda m:m.group(1)+blob+m.group(2),html)
svg='''<svg xmlns="http://www.w3.org/2000/svg" width="560" height="120" viewBox="0 0 560 120">
<rect x="4" y="8" width="104" height="104" rx="22" fill="#1f5fd6"/>
<path d="M40 50 a18 18 0 1 1 30 13 c-6 5 -9 9 -9 16 v4" fill="none" stroke="#fff" stroke-width="10" stroke-linecap="round"/>
<circle cx="61" cy="96" r="6" fill="#fff"/>
<text x="130" y="68" font-family="Helvetica,Arial,sans-serif" font-size="46" font-weight="700" fill="#222">Example Children's</text>
<text x="132" y="100" font-family="Helvetica,Arial,sans-serif" font-size="22" fill="#666">Pediatric Audiology</text></svg>'''
LH={"logo":"data:image/svg+xml;base64,"+base64.b64encode(svg.encode()).decode(),
    "contact":"Example Children's Hospital\nSpecialty Care Center, Audiology\n100 Hospital Drive, Anytown, TX 75000\nPhone (555) 555-0100 · Fax (555) 555-0101",
    "signer1":"","signer2":"","docId":"EHDI Report","bcPages":"first"}
REP={"repName":"J. Doe, Au.D., CCC-A","repLicense":"AU 00000","repPhone":"(555) 555-0100","repFax":"(555) 555-0101",
     "repFacility":"Example Children's Hospital, Audiology","repEmail":"audiology@example.org","repAddress":"100 Hospital Drive, Anytown, TX 75000"}
SETTINGS={"state":"TX","reporter":REP,"stateEdits":{}}
f={"childName":"Patient, Sample","childDob":"03/02/2026","birthPlace":"Example Regional Medical Center","birthCity":"Anytown","birthCounty":"Example County","birthState":"TX",
 "motherName":"Patient, Mother","motherMaiden":"","motherDob":"","otherNames":"Baby Boy Patient","mrn":"000000","nbsId":"",
 "guardianName":"Mother Patient, mother","guardianPhone":"(555) 555-0123","guardianEmail":"","guardianAddress":"200 Example Street, Anytown, TX 75000",
 "homeLanguage":"English","pcp":"Dr. R. Example, Anytown Pediatrics, (555) 555-0200, fax (555) 555-0201",
 "visitDate":"09/16/2026","reportDate":"09/16/2026","cmvDate":"03/04/2026","dxDate":"09/16/2026","cause":"",
 "nextVisit":"Behavioral evaluation (VRA) at 9 months; hearing aid fitting in 2 weeks","eiDate":"09/16/2026","sharedDate":"09/16/2026",
 "recommendations":"• Hearing aid evaluation and fitting, both ears\n• Otolaryngology (ENT) evaluation\n• Genetics evaluation and counseling\n• Referral to early intervention services (ECI)\n• Behavioral audiologic evaluation (VRA) at 9 months",
 "comments":"Click and toneburst ABR in natural sleep. Wave V replicated at each level reported. Bone conduction at 500 Hz and 2 kHz with contralateral masking. Results reviewed with mother.",
 "stateCode":"TX",**REP,
 "res_tymp_R":"1000 Hz probe: normal peak","res_tymp_L":"1000 Hz probe: normal peak","res_oae_R":"Absent","res_oae_L":"Absent",
 "res_click_R":"80 dB nHL (latencies within normal limits)","res_click_L":"80 dB nHL (latencies within normal limits)"}
for e,air,bone in (("R",["30*","30","30","35"],["25M","","30M",""]),("L",["40","40","45M","40"],["30M","","35M",""])):
    for fr,a,b in zip(["500","1000","2000","4000"],air,bone):
        f[f"tr_estAir_{e}_{fr}"]=a
        if b: f[f"tr_estBone_{e}_{fr}"]=b
c={k:True for k in ["kindNew","sexM","multSingle","seqFirst","condSleep","rsnScreen","rsnRisk","outDone","nbsRFail","nbsLFail","nbsAABR","cmvNeg",
 "tTymp","tymp1000","tDPOAE","tClick","tTone","tBoneABR","st_loss_R","st_loss_L","ty_sn_R","ty_sn_L","pm_perm_R","pm_perm_L","dg_2_R","dg_3_L",
 "cf_flat_R","cf_flat_L","onCong","fuContinue","comYes","ampHARec","eiReferred","shParent","shPCP","shEI","refENT","refGenetics","refFamily",
 "rk_1","optRisk","optResults"]}
form=(ROOT/"ehdi-report.html").read_text()
(OUT/"ehdi-report.html").write_text(embed(embed(embed(form,"letterhead",LH),"settings",SETTINGS),"saved-state",{"version":1,"form":"ehdi","fields":f,"checks":c}))
chip='font:600 15px -apple-system,Helvetica,Arial,sans-serif;color:#fff;background:#3a3d44;border-radius:999px;padding:7px 15px;display:inline-block'
(OUT/"screen.html").write_text(f'''<!doctype html><html><body style="margin:0;background:#eceef2;padding:16px 20px">
<div style="{chip}">Screenshot of the form open in a web browser</div>
<div style="margin-top:12px;border-radius:10px 10px 0 0;overflow:hidden;box-shadow:0 2px 12px rgba(0,0,0,.18);width:1024px">
<div style="background:#e4e5e9;height:30px;display:flex;align-items:center;padding:0 12px;gap:7px">
<span style="width:12px;height:12px;border-radius:50%;background:#ff5f57"></span><span style="width:12px;height:12px;border-radius:50%;background:#febc2e"></span><span style="width:12px;height:12px;border-radius:50%;background:#28c840"></span>
<div style="margin:0 auto;background:#fff;border-radius:6px;width:420px;text-align:center;font:12px -apple-system,Helvetica,Arial,sans-serif;color:#444;padding:3px 0">ehdi-report.html</div></div>
<iframe src="ehdi-report.html" style="width:1024px;height:1210px;border:0;display:block;background:#e9eaee"></iframe></div></body></html>''')
for n in (1,2,3):
    (OUT/f"print{n}.html").write_text(f'''<!doctype html><html><body style="margin:0;background:#eceef2;padding:16px 24px">
<div style="{chip}">Screenshot of printed page {n} of 3</div>
<img src="p-{n}.png" style="display:block;width:612px;margin-top:14px;background:#fff;box-shadow:0 3px 14px rgba(0,0,0,.2)"></body></html>''')
print("ok")
EOF
python3 $SP/sample.py $SP/shots "$REPO" && cd $SP/shots && CH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" && "$CH" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=$SP/shots/sample.pdf "file://$SP/shots/ehdi-report.html" 2>/dev/null && pdfinfo sample.pdf | grep Pages && pdftoppm -r 200 -png sample.pdf p && ls && "$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=1064,1297 --virtual-time-budget=3000 --allow-file-access-from-files --screenshot=$SP/shots/form-on-screen.png "file://$SP/shots/screen.html" 2>/dev/null; for n in 1 2 3; do "$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=660,868 --virtual-time-budget=2000 --screenshot=$SP/shots/printed-page-$n.png "file://$SP/shots/print$n.html" 2>/dev/null; done; ls -la $SP/shots/*.png | awk '{print $5,$9}'
for n in form-on-screen printed-page-1 printed-page-2 printed-page-3; do cp "$SP/shots/$n.png" "$REPO/docs/ehdi/$n.png"; done
echo "Updated docs/ehdi"

