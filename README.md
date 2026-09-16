# Editable Audiogram

A free audiogram form you fill in on your computer and print to a clean PDF.

It is one file, `audiogram.html`, that opens in any web browser (Chrome, Edge, Safari, Firefox). Nothing to install, no account, no subscription. You type in the student's information, click on the chart to plot thresholds, and print. Every printout is sharp, because the chart is drawn fresh each time instead of being a copy of a copy.

It was made for educational audiologists who needed an editable audiogram and couldn't find one to buy.

This page is just a description of it, with a download link and some pictures. The form itself is the file you download in the next section.

## How to download it

1. **Click this link: [Download audiogram.html](https://github.com/citizenkade/editable-audiogram/releases/latest/download/audiogram.html)**
2. Your browser saves it to your Downloads folder. If it asks whether to keep the file, choose Keep.
3. Open your Downloads folder and double-click `audiogram.html`. It opens in your browser, ready to use.

Move the file wherever you like: your desktop, Google Drive, a USB stick. It works from anywhere, and you can email it to a colleague.

If the link above doesn't work for you, there's a second way: click the green **Code** button near the top of this page, choose **Download ZIP**, then unzip it and open `audiogram.html`.

## What it looks like

These are pictures, not the form itself. Clicking on them won't fill anything in. Clicking a picture downloads the real form, same as the link above.

Filling it in on screen. You pick a symbol from the toolbar at the top, click on the chart, and the symbol snaps into place.

[![Screenshot of the form open in a web browser, with a sample audiogram plotted](docs/form-on-screen.png)](https://github.com/citizenkade/editable-audiogram/releases/latest/download/audiogram.html)

What comes out of the printer, or the PDF you save. One US Letter page.

[![Screenshot of the printed page](docs/printed-page.png)](https://github.com/citizenkade/editable-audiogram/releases/latest/download/audiogram.html)

## How to use it

- **Type** into any box. The age fills in on its own from the date of birth and evaluation date.
- **Plot** by choosing a symbol in the toolbar (R air, L bone, and so on) and clicking on the chart. Symbols snap to the nearest frequency and 5 dB step. Air-conduction thresholds connect automatically.
- **No response**: click the "No response" button first, then plot. The symbol gets an arrow. Click the button again to turn it off.
- **Fix a mistake**: click again at the right level to move a symbol, right-click a symbol to remove it, or use Undo.
- **Pure-tone average** (500, 1000, 2000, and 4000 Hz) calculates itself for each ear once all four thresholds are plotted.
- **Print / Save as PDF** opens your print dialog. Choose "Save as PDF" as the printer to get a PDF file.
- **Print blank form** prints an empty copy for hand-plotting.
- **Copy chart image** puts a picture of the chart and key on your clipboard, ready to paste into a report or email.
- **Save file** downloads a copy of the form with everything filled in, named after the student and date. Open that copy later to see or change the evaluation. Your original stays blank, so keep it as your master.

## ABR report

There is a second form, `abr-report.html`, for auditory brainstem response evaluations. It works the same way: one file, opens in any browser, prints to a two-page PDF. It has its own download link:

**[Download abr-report.html](https://github.com/citizenkade/editable-audiogram/releases/latest/download/abr-report.html)**

What is different from the audiogram form:

- **Thresholds are typed, not clicked.** Enter ABR thresholds in dB nHL for click and toneburst stimuli, by ear and by air or bone conduction. Write `35*` when the lowest level tested had a response, and `NR 90` for no response at 90.
- **Estimated behavioral thresholds** (dB eHL) fill in on their own from the measured table, using a correction for each stimulus. The corrections are editable and the printout states which ones were used. Untick "Calculate from measured" to type the estimates yourself.
- **The audiogram draws itself** from the estimated table.
- **Page 2** holds otoacoustic emissions, immittance, a summary of hearing status, the interpretation, a recommendations checklist, and the signature.

## Privacy

Nothing you type leaves your computer. There is no server, no account, and no automatic saving. Student information exists only in the PDFs and files you choose to save.

## Questions and requests

If something is wrong or you want a change, click the **Issues** tab at the top of this page and describe it. You'll need a free GitHub account to post there. Or reply on the Facebook post where you found this.

## License

MIT. Free to use, share, and modify.
