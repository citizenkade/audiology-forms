# Audiology Forms

Free forms for audiologists. Each one is a single file that opens in any web browser (Chrome, Edge, Safari, Firefox), fills in on screen, and prints to a clean PDF. Nothing to install, no account, no subscription, and nothing you type leaves your computer.

They were made for educational audiologists who needed editable forms and couldn't find good ones to buy.

| Form | What it's for | Download |
| --- | --- | --- |
| **Audiogram** | Pure-tone audiogram with click-to-plot chart, speech audiometry, tympanometry, OAEs, and otoscopy. One page. | **[audiogram.html](https://github.com/citizenkade/audiology-forms/releases/latest/download/audiogram.html)** |
| **ABR report** | Auditory brainstem response evaluation with measured and estimated thresholds, an audiogram drawn from the estimates, and page two for OAEs, immittance, interpretation, and recommendations. Two pages. | **[abr-report.html](https://github.com/citizenkade/audiology-forms/releases/latest/download/abr-report.html)** |

This page is a description of the forms, with download links and some pictures. The forms themselves are the files you download.

## How to download a form

1. Click its download link in the table above.
2. Your browser saves the file to your Downloads folder. If it asks whether to keep the file, choose Keep.
3. Open your Downloads folder and double-click the file. It opens in your browser, ready to use.

Move the file wherever you like: your desktop, Google Drive, a USB stick. It works from anywhere, and you can email it to a colleague.

If a link doesn't work for you, there's a second way: click the green **Code** button near the top of this page, choose **Download ZIP**, then unzip it and open the form you want.

## Audiogram

These are pictures, not the form itself. Clicking on them won't fill anything in. Clicking a picture downloads the real form, same as the link above.

Filling it in on screen. You pick a symbol from the toolbar at the top, click on the chart, and the symbol snaps into place.

[![Screenshot of the form open in a web browser, with a sample audiogram plotted](docs/audiogram/form-on-screen.png)](https://github.com/citizenkade/audiology-forms/releases/latest/download/audiogram.html)

What comes out of the printer, or the PDF you save. One US Letter page.

[![Screenshot of the printed page](docs/audiogram/printed-page.png)](https://github.com/citizenkade/audiology-forms/releases/latest/download/audiogram.html)

How to use it:

- **Type** into any box. The age fills in on its own from the date of birth and evaluation date.
- **Plot** by choosing a symbol in the toolbar (R air, L bone, and so on) and clicking on the chart. Symbols snap to the nearest frequency and 5 dB step. Air-conduction thresholds connect automatically.
- **No response**: click the "No response" button first, then plot. The symbol gets an arrow. Click the button again to turn it off.
- **Fix a mistake**: click again at the right level to move a symbol, right-click a symbol to remove it, or use Undo.
- **Pure-tone average** (500, 1000, 2000, and 4000 Hz) calculates itself for each ear once all four thresholds are plotted.
- **Speech audiometry** has separate rows for SRT and SDT, masking for thresholds and for word recognition, and Recorded / MLV checkboxes for each.
- **Print / Save as PDF** opens your print dialog. Choose "Save as PDF" as the printer to get a PDF file.
- **Print blank form** prints an empty copy for hand-plotting.
- **Copy chart image** puts a picture of the chart and key on your clipboard, ready to paste into a report or email.
- **Save evaluation** downloads a copy of the form with everything filled in, named after the student and date. Open that copy later to see or change the evaluation. Your original stays blank, so keep it as your master.
- **Clear form** empties every field, ready for the next student.

## ABR report

Again, these are pictures; clicking one downloads the real form.

Filling it in on screen. Thresholds go into the measured table, and the estimated table and the audiogram follow. You can also plot on the chart, and the tables follow that.

[![Screenshot of the ABR report open in a web browser, with sample thresholds and the estimated audiogram](docs/abr/form-on-screen.png)](https://github.com/citizenkade/audiology-forms/releases/latest/download/abr-report.html)

What comes out of the printer. Two US Letter pages.

[![Screenshot of printed page 1](docs/abr/printed-page-1.png)](https://github.com/citizenkade/audiology-forms/releases/latest/download/abr-report.html)

[![Screenshot of printed page 2](docs/abr/printed-page-2.png)](https://github.com/citizenkade/audiology-forms/releases/latest/download/abr-report.html)

It works the same way as the audiogram: one file, opens in any browser, prints to PDF. What is different:

- **Thresholds are typed or plotted.** Enter ABR thresholds in dB nHL for click and toneburst stimuli, by ear and by air or bone conduction. Write `35*` when the lowest level tested had a response, `NR 90` for no response at 90, and add `M` for a masked threshold (`45M`, `NR 90M`). Or pick a symbol in the toolbar and click on the chart, the same as the audiogram form; the click fills in the matching table cell. Clicking a symbol that is already there switches it between masked and unmasked.
- **Tab moves down the column**, so you can enter the whole right ear, then the left, then right bone, then left bone.
- **Estimated behavioral thresholds** (dB eHL) fill in on their own from the measured table while "Auto-fill using correction factors" is ticked. Click *correction factors* to see or change them: one set for air conduction, one for bone. The printout states which ones were used. Untick auto-fill to type the estimates yourself.
- **The audiogram draws itself** from the estimated table, with masked symbols where you marked them.
- **Page 1** also holds the history, testing notes, click latencies, and otoscopy. **Page 2** holds otoacoustic emissions, immittance, a summary of hearing status, the interpretation, a recommendations checklist, and the signature. Two recommendations ask a follow-up question when ticked: whether a hearing aid consult was completed today, and whether a cochlear implant referral was placed today.
- **Correction factors are saved with your letterhead.** Save a master copy (below) and a colleague who opens it gets the same corrections.

## Your letterhead

Both forms have a **Letterhead…** button in the toolbar that puts your logo, office details, and name on every printout. You can set a logo, up to four lines of office contact information, your name and credentials for under the signature line, and a document identifier that prints as a barcode for records systems that file by type, on the first page, the last page, or every page. Each is optional.

The letterhead prints right away, but the form can't save it into itself. To keep it, click **Save master copy**, in the toolbar or in the panel. That downloads a blank copy of the form (`audiogram.html` or `abr-report.html`) with your letterhead built in, and for the ABR report your correction factors too. Use that file from now on, and give it to colleagues so everyone prints the same letterhead. Evaluations you save carry the letterhead too.

## Privacy

Nothing you type leaves your computer. There is no server, no account, and no automatic saving. Student and patient information exists only in the PDFs and files you choose to save.

## Questions and requests

If something is wrong or you want a change, click the **Issues** tab at the top of this page and describe it. You'll need a free GitHub account to post there. Or reply on the Facebook post where you found this.

## License

MIT. Free to use, share, and modify.
