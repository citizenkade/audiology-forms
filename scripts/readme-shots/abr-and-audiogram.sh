#!/bin/bash
# Rebuilds the README screenshots in docs/abr and docs/audiogram/ from a sample-filled copy of the form.
# Usage: bash scripts/readme-shots/abr-and-audiogram.sh [work-dir]   (needs Google Chrome, poppler's pdftoppm, and Pillow)
# The work dir (default: a fresh temp dir) holds the sample form, the wrapper pages, and the raw PNGs.
set -e
REPO="$(cd "$(dirname "$0")/../.." && pwd)"
WORK="${1:-$(mktemp -d)}"
cd "$REPO" && S="$WORK" && mkdir -p "$S/shots" && python3 - "$S" <<'EOF'
import json,re,base64,sys
S=sys.argv[1]
def emb(html,i,obj):
    j=json.dumps(obj).replace('<','\\u003c')
    return re.sub(r'(<script type="application/json" id="%s">)[\s\S]*?(</script>)'%i, lambda m:m.group(1)+j+m.group(2), html)
def logo(line1,line2):
    svg=f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 90"><rect x="4" y="4" width="82" height="82" rx="16" fill="#1f4fd1"/><path d="M33 52a14 14 0 0 1 28 0c0 10-9 11-9 20M45 80v0" stroke="#fff" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="45" cy="52" r="4" fill="#fff"/><text x="104" y="48" font-family="Helvetica,Arial" font-size="34" font-weight="700" fill="#222">{line1}</text><text x="104" y="74" font-family="Helvetica,Arial" font-size="16" fill="#555">{line2}</text></svg>'''
    return 'data:image/svg+xml;base64,'+base64.b64encode(svg.encode()).decode()

# ---- ABR sample ----
lh={"logo":logo("Example Children's","Pediatric Audiology"),"contact":"Example Children's Hospital\nSpecialty Care Center, Audiology\n100 Hospital Drive, Anytown, TX 75000\nPhone (555) 555-0100 · Fax (555) 555-0101","signer1":"J. Doe, AuD, CCC-A","signer2":"jdoe@examplechildrens.org","docId":"ABR Report","bcPages":"all"}
settings={"corr":{"air":{"click":0,"500":15,"1000":10,"2000":5,"4000":0,"8000":0},"bone":{"click":0,"500":10,"1000":5,"2000":0,"4000":0}}}
f={"patient":"Sample Patient","dob":"03/02/2026","age":"6 mo","id":"000000","date":"09/16/2026","examiner":"J. Doe, AuD","referredBy":"Dr. R. Example, Pediatrics","correctedAge":"5 mo","facility":"Example Children's, Audiology","reason":"Referred after NHS refer, bilateral","nhs":"Refer both ears, 03/03/2026, AABR",
"stateNotes":"Fed and swaddled; slept through recording","equipment":"Two-channel evoked potential system, insert earphones, B-71 oscillator","qualityNotes":"Low noise; a few movement artifacts at 500 Hz left",
"history":"Born at 38 weeks by uncomplicated delivery and referred bilaterally on the newborn hearing screen (AABR). No NICU stay, no family history of childhood hearing loss, no ototoxic medications. Parents report startle to loud sounds but inconsistent response to voice. One episode of otitis media, resolved. Today's visit is the diagnostic ABR following the screening refer.",
"testingNotes":"Click and toneburst ABR completed in natural sleep. Wave V replicated at each level reported. Bone conduction at 500 Hz and 2 kHz with contralateral masking. 4 kHz left air: response at 40 with clear morphology; 35 absent.",
"nhl_R_click":"35","nhl_L_click":"45","nhl_R_500":"45*","nhl_L_500":"55","nhl_RB_500":"35M","nhl_LB_500":"40M","nhl_R_1000":"40","nhl_L_1000":"50","nhl_R_2000":"35","nhl_L_2000":"50M","nhl_RB_2000":"30M","nhl_LB_2000":"35M","nhl_R_4000":"35","nhl_L_4000":"40","nhl_R_8000":"40","nhl_L_8000":"NR 90",
"latLevelR":"80","latLevelL":"80","latIR":"1.72","latIL":"1.80","latIIIR":"4.10","latIIIL":"4.22","latVR":"6.05","latVL":"6.30","latIVR":"4.33","latIVL":"4.50",
"otoR":"Clear canal, TM intact, normal landmarks","otoL":"Clear canal, TM intact, normal landmarks",
"oaeRNotes":"Absent 2–8 kHz","oaeLNotes":"Absent 2–8 kHz","oaeType":"DPOAE, 2–8 kHz, 65/55 dB SPL",
"tympR":"Type A (1000 Hz), normal admittance","tympL":"Type A (1000 Hz), normal admittance",
"summaryR":"Mild sensorineural hearing loss, flat configuration","summaryL":"Mild to moderate sensorineural hearing loss, sloping",
"interpretation":"Today's ABR results are consistent with a mild sensorineural hearing loss in the right ear and a mild-to-moderate sloping sensorineural hearing loss in the left ear. Air- and bone-conduction estimates agree within 5 dB where both were measured, and tympanometry was normal bilaterally, which argues against a conductive component. Absolute and interpeak latencies at 80 dB nHL were within age-appropriate limits for both ears. These findings represent permanent hearing loss of a degree that will affect speech and language development without intervention.",
"rec4x":"3 months, natural sleep, to confirm left 4 kHz","rec5x":"9 months (VRA)","rec14x":"Loaner hearing aids while the family selects devices","sigDate":"09/16/2026"}
c={"autoCalc":True,"sSleep":True,"tInserts":True,"tBone":True,"stClick":True,"stToneburst":True,"qGood":True,"oaeRAbsent":True,"oaeLAbsent":True,"pt1000":True,"rec1":True,"rec2":True,"rec16":True,"rec3":True,"rec4":True,"rec5":True,"rec6":True,"rec6Yes":True,"rec8":True,"rec14":True}
h=open('abr-report.html').read()
open(S+'/shots/abr-sample.html','w').write(emb(emb(emb(h,'saved-state',{"version":2,"form":"abr","fields":f,"checks":c,"showBands":True}),'letterhead',lh),'settings',settings))

# ---- Audiogram sample (rebuilt to match the earlier README shot) ----
alh={"logo":logo("Example ISD","Audiology Services"),"contact":"Example ISD Audiology Services\n100 School Lane, Anytown, TX 75000\nPhone (555) 555-0100\nFax (555) 555-0101","signer1":"J. Doe, AuD, CCC-A","signer2":"jdoe@exampleisd.org","docId":"Audio Eval","bcPages":"first"}
af={"student":"Sample Student","dob":"03/05/2018","age":"8 yr 6 mo","id":"000000","school":"Example Elementary","grade":"3","date":"9/14/2026","examiner":"J. Doe, AuD","facility":"Example ISD","referredBy":"Classroom teacher","reason":"Failed hearing screening",
"tympTypeR":"A","tympTypeL":"A","ecvR":"0.9","ecvL":"1.0","tppR":"-15","tppL":"-20","admR":"0.6","admL":"0.7","reflexR":"Present","reflexL":"Present",
"srtR":"40","srtL":"55","wrsR":"92","wrsL":"84","wrsLevelR":"75","wrsLevelL":"85","wrsListR":"PBK","wrsListL":"PBK","oaeType":"DPOAE","otoR":"Clear","otoL":"Clear",
"comments":"Mild sloping to moderately severe sensorineural hearing loss in the right ear. Moderate sloping to profound sensorineural hearing loss in the left ear. Recommend preferential seating, a classroom FM/DM system, and an audiology follow-up in 6 months.","sigDate":"9/14/2026"}
ac={"tInserts":True,"mConv":True,"rGood":True,"srtRecorded":True,"wrsRecorded":True,"oaeRRefer":True,"oaeLRefer":True}
pts=[("RA",250,20),("RA",500,30),("RA",1000,35),("RA",2000,40),("RA",4000,55),("RA",8000,60),
     ("LA",250,25),("LA",500,35),("LA",1000,45),("LA",2000,50),("LA",4000,60),("LA",6000,110,True),("LA",8000,115,True),
     ("RB",500,25),("RB",1000,30),("RBM",2000,40),("RB",4000,50),("LBM",500,35),("LBM",2000,50),("S",750,20),("S",1500,25)]
apts=[{"type":t,"freq":fq,"db":db,"nr":len(p)>3} for p in pts for (t,fq,db,*_) in [p]]
a=open('audiogram.html').read()
open(S+'/shots/aud-sample.html','w').write(emb(emb(a,'saved-state',{"version":1,"fields":af,"checks":ac,"points":apts,"showBands":True}),'letterhead',alh))

# ---- wrapper pages ----
CSS='''<style>html,body{margin:0}body{background:#e9e9ee;font-family:-apple-system,"Segoe UI",Helvetica,Arial,sans-serif;padding:14px 24px 24px}
.chip{display:inline-block;background:#3a3d44;color:#fff;font-weight:700;font-size:14px;padding:6px 12px;border-radius:12px;margin:0 0 12px}
.win{background:#fff;border-radius:10px;overflow:hidden;box-shadow:0 1px 2px rgba(0,0,0,.08)}
.bar{background:#ecedf1;height:36px;display:flex;align-items:center;padding:0 12px;position:relative}
.bar i{width:10px;height:10px;border-radius:50%;display:inline-block;margin-right:6px}
.url{position:absolute;left:50%;transform:translateX(-50%);background:#fff;border-radius:7px;padding:3px 0;width:320px;text-align:center;font-size:11px;color:#333}
iframe{display:block;border:0;width:100%}
.page{display:block;width:612px;box-shadow:0 2px 12px rgba(0,0,0,.18);background:#fff}
</style>'''
def win(src,h,url): return f'<!DOCTYPE html><html><head>{CSS}</head><body><div class="chip">Screenshot of the form open in a web browser</div><div class="win"><div class="bar"><i style="background:#ff5f57"></i><i style="background:#febc2e"></i><i style="background:#28c840"></i><span class="url">{url}</span></div><iframe src="{src}" style="height:{h}px"></iframe></div></body></html>'
def page(img,cap): return f'<!DOCTYPE html><html><head>{CSS}</head><body><div class="chip">{cap}</div><img class="page" src="{img}"></body></html>'
open(S+'/shots/abr-screen.html','w').write(win('abr-sample.html',1225,'abr-report.html'))
open(S+'/shots/aud-screen.html','w').write(win('aud-sample.html',1235,'audiogram.html'))
open(S+'/shots/abr-p1.html','w').write(page('abr-page-1.png','Screenshot of printed page 1 of 2'))
open(S+'/shots/abr-p2.html','w').write(page('abr-page-2.png','Screenshot of printed page 2 of 2'))
open(S+'/shots/aud-p1.html','w').write(page('aud-page-1.png','Screenshot of the printed page'))
print('built')
EOF
CH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
cd "$S/shots"
"$CH" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=abr.pdf "file://$S/shots/abr-sample.html" 2>/dev/null; pdfinfo abr.pdf | grep Pages
"$CH" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=aud.pdf "file://$S/shots/aud-sample.html" 2>/dev/null; pdfinfo aud.pdf | grep Pages
pdftoppm -r 200 -png abr.pdf abr-page && pdftoppm -r 200 -png aud.pdf aud-page && ls *.png
"$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=1064,1297 --screenshot="$S/shots/abr-form-on-screen.png" "file://$S/shots/abr-screen.html" 2>/dev/null
"$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=1064,1307 --screenshot="$S/shots/aud-form-on-screen.png" "file://$S/shots/aud-screen.html" 2>/dev/null
"$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=660,868 --screenshot="$S/shots/abr-printed-1.png" "file://$S/shots/abr-p1.html" 2>/dev/null
"$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=660,868 --screenshot="$S/shots/abr-printed-2.png" "file://$S/shots/abr-p2.html" 2>/dev/null
"$CH" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 --window-size=660,868 --screenshot="$S/shots/aud-printed.png" "file://$S/shots/aud-p1.html" 2>/dev/null
python3 -c "
from PIL import Image
for n in ['abr-form-on-screen','aud-form-on-screen','abr-printed-1','abr-printed-2','aud-printed']: print(n, Image.open('$S/shots/'+n+'.png').size)"
cd "$REPO"
cp "$S/shots/abr-form-on-screen.png" docs/abr/form-on-screen.png
cp "$S/shots/abr-printed-1.png" docs/abr/printed-page-1.png
cp "$S/shots/abr-printed-2.png" docs/abr/printed-page-2.png
cp "$S/shots/aud-form-on-screen.png" docs/audiogram/form-on-screen.png
cp "$S/shots/aud-printed.png" docs/audiogram/printed-page.png
echo "Updated docs/abr and docs/audiogram"

