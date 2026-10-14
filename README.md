# AG Repack GUI

A Windows GUI for building ARMGDDN game repacks: it fills in the installer settings, compiles the Inno Setup script, compresses the game data, merges the installer, and zips and names the final package. It can also build an **update patch** (old repack → new repack) with the bundled XDelta patch maker.

## Setup

The repo holds the whole toolkit (compressor, installer script, skins, patch maker, ...). The program itself is published separately under **Releases**, so you need both:

1. **Get the toolkit** — download the repo as a zip (**Code → Download ZIP**) and extract it, or clone it:
   ```
   git clone https://github.com/DeliciousMeatPop/AGrepackGUI
   ```
   Put it somewhere writable (not inside `Program Files`), or run the app as administrator.
2. **Get the program** — pick one:
   - **Exe (recommended):** download `AG Repack GUI.zip` from the [latest release](https://github.com/DeliciousMeatPop/AGrepackGUI/releases/latest) and extract it **into the toolkit folder**, so `AG Repack GUI.exe` and its `runtime` folder sit next to `7z.exe`, `COMPRESSOR`, `Resource`, `Setup`, etc.
   - **Python:** with Python 3.8+ (tkinter is included with the standard Windows install), run `python DMPRepackGUI.py` from the toolkit folder.

The app finds everything relative to its own folder, so the toolkit can live anywhere and be moved freely. When a newer release is published, the exe offers to update itself.

## Making a repack

1. Open **AG Repack GUI**, choose the game directory, and fill in the name, App ID, build and the other settings (a Steam App ID auto-fills what it can).
2. On **Build & Pack**, pick a compression preset and click **RUN FULL REPACK**.
3. The finished, named package ends up in the toolkit folder. Game art is saved to `Setup/` and archived with the repack.

The *Manual Steps* section runs each stage on its own; you normally won't need it.

## Making an update patch

**Where `XDelta` lives.** The patch tools fail on long paths, so the `XDelta` folder has to sit **beside the toolkit folder (`ARMGDDN Repacks`) — in the same parent folder — not inside it**:

```
D:\Repos\
├── ARMGDDN Repacks\     <- the toolkit (this repo)
└── XDelta\              <- right next to it, same parent
```

The shared package already comes laid out like this; keep the two together if you move them. Nothing moves it for you: when a patch is needed, the repacker and `Patch Builder.bat` check for `..\XDelta` and show a hard-to-miss popup if it isn't there — put the folder there, then click **Retry**. (If you cloned the repo, `XDelta/` arrives inside the toolkit; move it out to the parent first. Git will then show it as deleted in the toolkit; that's expected.)

Tick **Also make an update patch (XDelta)** on **Build & Pack** and fill in:

- **Old repack installer** — the old repack's `setup.exe` or `AGRepackInstaller.exe`
- **Old repack Build ID** — usually digits, but anything without spaces works for non-Steam games and VR mods (you'll be asked to confirm if it isn't a plain number)

If either is missing when the run starts, you'll be asked for it. Then:

1. The old repack is installed silently to `XDelta\Games\old\<game>` while the new one compresses.
2. When the new installer is ready you get a dialog with the old and new release names (`Game vBUILD -ARMGDDN`). Check them, edit if needed, and hit **Next**.
3. The new repack is installed silently to `XDelta\Games\new\<game>` — without an uninstaller, so the patch removes the old one instead of leaving it broken.
4. The patch maker opens pre-filled. Click **Build Patch** there while the repack finishes zipping.

Installs use no start menu entries or desktop shortcuts. If `XDelta\Games\old` / `new` still hold files from a previous patch you're asked before they're cleared.

The patch maker also works on its own: run **Patch Builder.bat** (in the toolkit folder) and type the old and new release names yourself. Its 7-Zip and music settings are stored relative to the `XDelta` or toolkit folder, so nothing needs editing on a new machine (it defaults to the `7z.exe` in the toolkit root).

## Uploading to the testing remote

When a repack finishes (zipped, named, game art backed up) the GUI offers to upload it. Choose:

- **Copy** (leave the files here) or **Move** (upload, then delete the local copy — only files rclone has transferred are ever deleted)
- **PC** or **PCVR** testing. This is *your* choice at that moment; it is not taken from the repack type, so a PCVR game that was packed as "PC" still goes to the PCVR remote.

Uploaded layout:

```
Game vBUILD -ARMGDDN\
├── <steam appid>                (empty file, Steam games only)
└── Game vBUILD -ARMGDDN.7z      (or .7z.001, .7z.002 ... — split into 5000M parts over 10 GB)
```

With an update patch the repack is nested and the patch sits beside it:

```
Game vBUILD -ARMGDDN\
├── <steam appid>
└── Game vBUILD -ARMGDDN\        (multi-part .7z.00x inside)
Game vOLDBUILD-NEWBUILD_Update_Patch\   (zipped if more than one file, split over 10 GB; a lone exe is left as is)
```

Live upload progress (`rclone -P`) is drawn in the console window — the same one that shows the compression — and details go to `rclone_upload.log`. (Running without a console window? Progress lines appear in the GUI log instead.) Don't add `-P` to `remotes.ini`; it's handled for you.

The patch is waited for and uploaded together with the repack. A failed upload stops immediately and leaves your local files in place; **Manual Steps → 9. Upload to Testing…** re-runs it on any package folder.

Setup (per repacker, **never committed**): put these three files next to the program (`AG Repack GUI.exe` / `DMPRepackGUI.py`):

| File | What it is |
|---|---|
| `rclone.exe` | The custom rclone build (it carries the config password itself) |
| `rclone.conf` | The encrypted rclone config |
| `remotes.ini` | Maps `pc` / `pcvr` to `remote:path` — copy `remotes.ini.example` and edit |

If any of them is missing the upload step is skipped with a note in the log, and the repack finishes as normal.

(Posting to AGTesting has its own optional `agtesting.ini` — see below.)

## Posting to AGTesting

After an upload the GUI can post the release to the AGTesting site for you. The upload dialog gets a **Post to AGTesting when the upload finishes** box (ticked by default; it only appears once `agtesting.ini` is set up).

**One-time setup** (per repacker, **never committed**): copy `agtesting.ini.example` to `agtesting.ini` next to the program and put the site address in it. The `[Types]` section maps the upload destination to the site's type (`pc` → PC, `pcvr` → VR by default; use `BOTH` if you want).

**First post — linking this PC.** The site logs in through Telegram, so the GUI never handles a login. Instead, the first time it posts it opens an approval page in your browser and shows a code like `ABCD-EFGH`:

1. Sign in with Telegram if the page asks.
2. Check the code on the page matches the one in the GUI, then click **Approve**.
3. The GUI picks up a personal token by itself and saves it as `agtesting.token` (next to the program). You won't be asked again on this PC.

Only repackers and admins can approve. Lost a PC or want to cut it off? Open the site's `/link.html` page while signed in and **Revoke** it — the next post just links again. Delete `agtesting.token` to force a re-link.

**What gets posted.** The site decides, from the release name (`Game vBUILD -ARMGDDN`):

| Situation | Result |
|---|---|
| New release | Posted to the testing channel like a normal submission (with its update patch, if the patch folder name is `Game vOLD-NEW_Update_Patch`) |
| Same name, current version posted **less than 30 minutes ago** | Nothing happens — treated as a double click or retry |
| Same name, posted longer ago | Treated as a redo: reposted for retesting like any other repost (old reports are kept, any claim is released) |

The 30 minutes is `REPOST_COOLDOWN_MINUTES` on the site. A repost does not add a new update patch entry.

**If a post fails** (site down, wrong account...) the upload is untouched. Use **Manual Steps → 10. Post to AGTesting…**, pick the package folder, and it posts without re-uploading.

## What's in the toolkit

| Folder / file | Purpose |
|---|---|
| `DMPRepackGUI.py` | The program (source) |
| `Script.iss`, `Registry.iss` | Installer script the repacks are built from |
| `COMPRESSOR/` | Compression tools and per-game presets |
| `Resource/`, `Resources/` | Compression presets, templates, installer modules |
| `Setup/` | Installer art, skins, music, EULAs; game art lands in `Setup/Background` |
| `XDelta/` | Update patch maker (`make_patch_gui.ps1`) and its tools — ships with the repo, but **must sit beside the toolkit folder (same parent)** — see above |
| `Patch Builder.bat` | Launches the patch maker by itself |
| `_PATCHING TOOLS/` | Optional third-party helpers for patching games |
| `Help/` | Installer script reference |
| `Build_EXE.bat` | Builds the exe locally (needs Python + PyInstaller) |

Not stored in the repo (see above for the upload files `rclone.exe`, `rclone.conf`, `remotes.ini` and the AGTesting files `agtesting.ini`, `agtesting.token`), created locally as you work: your saved repacker name (`Resource/Save/repacker.txt`), `Setup/Background/_OldGameArt/` (archived old game art), the built exe, and patch build output. Keep `_OldGameArt` in the folder when you zip up a release if you want it included.

## Building the exe yourself

Run `Build_EXE.bat`. It produces `dist\AG Repack GUI\` containing the exe and a `runtime` folder; drop both into the toolkit folder. Official builds come from the **Build & draft release** GitHub Action.
