# What's new in AG Repack GUI (since 1.1.4)

Everything below is already set up for you in this folder. The only thing you do yourself is a **one-time link** to your AGTesting account (section 4). If you're in a hurry, read the box below and section 4, then skim the rest when you need it.

> **The short version**
> 1. The **`XDelta` folder must stay beside the `ARMGDDN Repacks` folder** (same parent folder), never inside it. It's already packaged that way — just don't move it (only matters for update patches — section 2).
> 2. When a repack finishes, an **Upload window** appears. Pick **Copy/Move** and **PC/PCVR**. Leave **Post to AGTesting** ticked.
> 3. The first time you post, your browser opens once to link your Telegram account. Check the code matches, click **Approve**. Never asked again on that PC.
> 4. Name your folders exactly `Game Name vBUILDID -ARMGDDN`.

---

## 1. The new Upload step (uploads the finished repack for you)

**What it does:** after the repack is zipped, named and its art is backed up, the GUI offers to upload it to the testing storage. No more dragging it into rclone by hand.

**What you'll see:** a window called **Upload to testing** that lists the folder(s) about to go, with these choices:

- **Copy** — upload it and keep your local files.
- **Move** — upload it, then delete the local files. Only files that were fully uploaded and verified are deleted; if anything fails, nothing is removed.
- **PC testing** or **PCVR testing** — *you* choose where it goes. It is **not** guessed from the repack type, so a PCVR game that you packed as "PC" still goes to PCVR if you pick PCVR.
- **Post to AGTesting when the upload finishes** — see section 4.
- **Skip upload** — closes the window and does nothing.

**While it uploads:** live progress is drawn in the **black console window** (the same one that shows the compression), not in the GUI log. Long uploads can look quiet in the GUI itself — look at the console. If a console isn't available, progress lines appear in the GUI log instead. Details of the last upload are saved in `rclone_upload.log`.

**If it fails:** it stops straight away and leaves your local files alone. You can run it again later from **Manual Steps → 9. Upload to Testing…**, pick the finished package folder, and it uploads that without redoing the repack.

**What lands in the testing storage:**

```
Game vBUILD -ARMGDDN\
├── <steam appid>                (empty file, Steam games only)
└── Game vBUILD -ARMGDDN.7z      (or .7z.001, .7z.002 ... split into 5000M parts over 10 GB)
```

If there's an update patch, the repack is nested one level deeper and the patch sits beside it:

```
Game vBUILD -ARMGDDN\
├── <steam appid>
└── Game vBUILD -ARMGDDN\        (multi-part .7z.00x inside)
Game vOLDBUILD-NEWBUILD_Update_Patch\
```

You don't have to arrange any of this; the GUI does it.

---

## 2. The new Update Patch option (build a patch from the old repack to the new one)

Used when a game gets an update and you want to give people a small patch instead of a whole new download.

### Where the XDelta folder lives

`XDelta` (the patch maker) has to sit **beside the `ARMGDDN Repacks` folder — in the same parent folder** — and **not inside it**. The patch tools break when they're buried in long folder paths, so the program only looks for it there:

```
D:\Repos\                  <- any parent folder you like
├── ARMGDDN Repacks\       <- this folder (the toolkit, with the GUI in it)
└── XDelta\                <- must be right next to it, same parent
```

It comes packaged that way, so you don't need to do anything — just keep the two folders together if you move or copy them (move the *parent*, or move both). If you start a patch and `XDelta` isn't in the right place, a **big red-banner popup** tells you where it expected it; put the folder there and click **Retry**, or click **Skip update patch** to carry on without one.

### Making a patch

1. On **Build & Pack**, tick **Also make an update patch (XDelta)**.
2. Fill in:
   - **Old repack installer** — the old repack's `setup.exe` or `AGRepackInstaller.exe`.
   - **Old repack Build ID** — usually just numbers. If it isn't a plain number (non-Steam games and VR mods often aren't, like `1.0b`), you'll be asked "is this exactly right?" and can say Yes. No spaces or `\ / : * ? " < > |`.
   - If you forget either, you'll be asked for it at the right moment. Say no and the repack just carries on without a patch.
3. Click **RUN FULL REPACK** as usual. Behind the scenes:
   1. The **old repack is installed silently** (no windows, no shortcuts) into `XDelta\Games\old\` while the new one compresses.
   2. When the new installer is ready, a window shows the **old and new release names** (`Game vBUILD -ARMGDDN`). Check them, fix if needed, press **Next**.
   3. The **new repack is installed silently** into `XDelta\Games\new\` (deliberately *without* an uninstaller, so the patch cleanly replaces the old one).
   4. The **patch maker opens, already filled in.** Click **Build Patch** there. The repack keeps zipping while you do.
4. The GUI waits for the patch to finish, then uploads the repack and the patch together (section 1).

Good to know:
- If `XDelta\Games\old` or `new` still hold files from a previous patch, you're **asked before they're cleared** (answer No to skip the patch this time).
- If the old or new silent install fails, the patch is skipped and the repack finishes normally.
- The finished patch folder is named `Game vOLDBUILD-NEWBUILD_Update_Patch`. A single `.exe` is left as is; several files are zipped under the folder name (and split if over 10 GB).
- If you close the patch maker without building, the GUI asks whether to upload the repack **without** the patch.
- **Patch Builder.bat** (in this folder) opens the patch maker on its own — type the old and new release names yourself. It does the same XDelta-location check.

---

## 3. Manual Steps has two new buttons

Under **Manual Steps → Individual Steps** you now have:

- **9. Upload to Testing…** — upload a package folder you've already built (and optionally its patch folder).
- **10. Post to AGTesting…** — post an already-uploaded package folder to the testing site, **without uploading again**. Use this if a post failed (site down, no internet) or if you uploaded some other way.

You normally won't need either — they exist for when something goes wrong.

---

## 4. Posting to the AGTesting site (the part you set up once)

After a successful upload, the GUI tells the testing site about your release, so you don't post it by hand.

### First time only: link your PC

The site only lets people in through Telegram, and a program can't do a Telegram login, so the first post links this PC to your account:

1. A box pops up with a code like **`K7M2-Q9XA`**, and your **browser opens** the site's *Link a tool* page.
2. If the site asks, **sign in with Telegram** as you normally do (it brings you straight back to the Link page).
3. **Check the code on the page is the same as the one in the GUI box**, then click **Approve**. (If you didn't just start a post, click **Reject** — the code is how the site knows it's really you.)
4. Go back to the GUI. After a few seconds it says **Linked** and carries on posting.

That's it. The GUI saved a key in a file called `agtesting.token` next to the program, and it won't ask again on this PC.

- You must be a **repacker** or **admin** on the site. Testers can't link.
- You have about **10 minutes** to approve a code; after that just start the post again.
- **Treat `agtesting.token` like a password.** Anyone with that file can post as you. Don't send it, zip it up, or share this folder after you've linked (delete it first). If it ever leaks or you lose a PC, sign in at the site's `/link.html` page and click **Revoke**.

### Every time after that

When the upload finishes, the log shows one of these:

| You see | It means |
|---|---|
| `Posted to AGTesting: <name>` | New release — it's in the testing queue and announced in the channel |
| `Already on AGTesting - reposted for retesting: <name>` | You've posted this exact name before, **30 or more minutes ago**, so it's treated as a **redo**: it goes back into testing (old reports are kept, any claim on it is released) |
| `Already posted N min ago - left as is.` | The same name was posted **less than 30 minutes ago**, so it's treated as an accidental double-post and ignored |
| `[ERROR] Not posted: build ID already used by "<other name>"` | A *different* release already uses that build ID — check the name/build |
| `[ERROR] "<name>" is not in the form …` | The folder name doesn't match `Game Name vBUILDID -ARMGDDN` — rename it (the upload itself still worked) |

**How it knows it's a redo:** it goes by the **release name** (the folder name). Same name = same release.

**Update patches:** if your patch folder is named `Game vOLD-NEW_Update_Patch` with plain numbers for the old and new build, the site lists the patch too. A *redo* of an existing release does not add a new patch entry.

**If a post fails** (site down, no internet): you'll be offered **Retry**. If you give up, the upload is *not* undone — later just use **Manual Steps → 10. Post to AGTesting…**. Nothing needs uploading again.

**If you just want to upload and not post:** untick **Post to AGTesting when the upload finishes** in the Upload window for that run.

---

## 5. Smaller things you might notice

- **First-run wizard for the patch maker is gone.** It now uses the `7z.exe` that ships in the folder, and its settings are stored relative to the folder, so nothing needs editing after you unzip.
- **The XDelta check happens first.** If you ticked the update-patch option and `XDelta` isn't in the right place, you find out when you click **RUN FULL REPACK** — before any work starts — and can fix it, or choose to continue without a patch (or cancel the run).
- **Upload now happens at the end of a full repack.** After the "REPACK COMPLETE" message in the log, the Upload window appears; the final "Done" box shows once the upload (and post, if ticked) has finished.
- If something that needs a file isn't set up (for example `rclone.exe` is missing), that step is **skipped with a note in the log** and the repack still finishes normally.

---

## 6. If something goes wrong

| Problem | What to do |
|---|---|
| No "Post to AGTesting" box in the Upload window | `agtesting.ini` is missing or has no address in it. It must be named exactly `agtesting.ini` and sit next to the program |
| "Skipped" lines about rclone | `rclone.exe`, `rclone.conf` or `remotes.ini` is missing from the folder |
| Big red "XDelta NOT FOUND" popup | The `XDelta` folder isn't beside the `ARMGDDN Repacks` folder (same parent). Put it there (section 2), then **Retry** |
| Browser says the link code is invalid or expired | Wait-and-click took over 10 minutes. Start the post again for a new code |
| "This account can't post (needs the repacker or admin role)" | You've left the staff/repackers channels, or you're a tester. Ask an admin |
| "The saved AGTesting link is no longer valid" | Your link was revoked. It re-links by itself — just approve the new code |
| Upload looks stuck | Look at the black console window; progress is shown there |
| Anything else | Copy the red `[ERROR]` lines from the GUI log and send them to the admin |
