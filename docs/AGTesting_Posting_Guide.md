# Posting to AGTesting from AG Repack GUI — the complete setup guide

This guide takes you from "nothing done yet" to "I finish an upload and it shows up on the testing site by itself". It assumes you have never done any of this before. Every step says **where** you do it (your server, GitHub, or a repacker's Windows PC) and **how to check it worked**.

---

## 0. What you're building (the 2-minute version)

Before: you finish a repack, the GUI uploads it with rclone, and then you go to the testing site and post it by hand.

After: the GUI uploads it, then tells the testing site about it automatically.

The tricky part is that the testing site only lets people in through **Telegram login**, and a Windows program can't do a Telegram login. So there's a one-time "link" step per PC:

```
  Windows PC (the GUI)                              Testing site (AGTesting)
  ─────────────────────                             ────────────────────────
  1. "I'd like to link"  ─────────────────────────▶  gives back a short code
  2. opens your browser at /link.html ◀── you sign in with Telegram (like always)
                                                     you click Approve
  3. GUI asks "approved yet?" ────────────────────▶  hands over a personal token (once)
  4. saves it in  agtesting.token

  From now on, after every upload:
  5. "post this release" + token ─────────────────▶  decides: new / duplicate / redo
```

Your rule for redos is built in: if a release with the **same name** is posted again **30 minutes or more** after it was last posted, it's treated as a redo and goes back into testing; if it was posted less than 30 minutes ago, it's treated as an accidental double-post and ignored.

### The checklist (details for every line are below)

| # | Where | What | Section |
|---|---|---|---|
| 1 | Your server | Back up the site and database | 2 |
| 2 | GitHub | Merge the AGTesting branch into `main` | 3 |
| 3 | Your server | Put the new code on the server | 4 |
| 4 | Your server | Check `APP_URL`, run the migration, check nginx | 5–7 |
| 5 | GitHub | Merge the AGrepackGUI branch, publish a new GUI release | 8 |
| 6 | Each repacker's PC | Update the GUI, create `agtesting.ini` | 9 |
| 7 | Each repacker's PC | Test with a throwaway release | 10 |
| 8 | — | Use it for real | 12 |

Do the **server first, GUI second**. The GUI can't post to a server that doesn't have the new code yet.

---

## 1. What you need before you start

Tick these off. If you're missing one, sort it out first.

- [ ] **The testing site is already running** and you can log into it with Telegram. (If login doesn't work today, fix that first — this guide doesn't touch it.)
- [ ] **Server access.** Some way to run commands on the machine that hosts the site (SSH), *or* a way to upload files (SFTP / hosting control panel) plus a database tool (phpMyAdmin or similar).
- [ ] **The site's folder** on the server — the one that contains the folders `api`, `config`, `includes`, `migrations` and `public`. In this guide it's called **`<site folder>`**.
- [ ] **Database login.** Open `<site folder>/config/config.local.php` on the server. It contains `DB_NAME`, `DB_USER` and `DB_PASS`. Keep that file open — you'll need those values.
- [ ] **A GitHub account with write access** to both `DeliciousMeatPop/AGTesting` and `DeliciousMeatPop/AGrepackGUI`.
- [ ] **Your Telegram numeric ID** and a working role on the site. Your role must be **admin** or **repacker** — testers can't link a posting tool.
  - Admin = your Telegram ID is in `ADMIN_TELEGRAM_IDS` in the config.
  - Repacker = you're a member of **both** the staff channel and the repackers channel.
  - Don't know your numeric ID? Message `@userinfobot` on Telegram.
- [ ] **A way to edit text files** (Notepad is fine on Windows; `nano` on the server).

> **Words you'll see:** *branch* = a named copy of the code where changes are made safely. *Merge* = fold that copy into the main code (`main`). *Migration* = a small file that adds new tables to the database. *Token* = a long random password a program uses instead of you logging in.

---

## 2. Back up first (5 minutes, do not skip)

You're changing a live site. If something goes wrong, a backup turns a disaster into an inconvenience.

**On the server**, in a terminal (replace the capitalised words with the values from `config.local.php`):

```bash
# 1. Database dump (it will ask for DB_PASS)
mysqldump -u DB_USER -p DB_NAME > agtesting_backup_before_posting.sql

# 2. Copy of the site files, next to the site folder
cp -r "<site folder>" "<site folder>_backup_before_posting"
```

No SSH? In phpMyAdmin choose your database → **Export** → **Quick** → **Go**, and download the site folder over SFTP.

**Check it worked:** the `.sql` file exists and isn't 0 bytes (`ls -lh agtesting_backup_before_posting.sql`).

---

## 3. Merge the AGTesting changes on GitHub

The new code is on a branch called `claude/charming-bardeen-ld3tse` in each repo. Nothing is live until you merge it.

1. Go to <https://github.com/DeliciousMeatPop/AGTesting>.
2. Click **Pull requests** → **New pull request**.
3. Set **base: `main`** and **compare: `claude/charming-bardeen-ld3tse`**.
4. Click **Create pull request**, then open the **Files changed** tab and skim it. You should see these files (and nothing surprising):

   | File | What it is |
   |---|---|
   | `migrations/010_api_tokens_and_device_codes.sql` | New: the two new database tables |
   | `api/device.php` | New: the "link a tool" endpoint |
   | `public/link.html` | New: the approval page you see in the browser |
   | `api/repacks.php` | Changed: new `submit` action (new / duplicate / redo logic) |
   | `includes/Auth.php` | Changed: accepts a token as well as a browser login |
   | `api/telegram_callback.php` | Changed: returns you to the link page after Telegram login |
   | `config/config.php` | Changed: three new settings with defaults |

5. Click **Merge pull request** → **Confirm merge**.

> Prefer the command line? `git checkout main && git merge claude/charming-bardeen-ld3tse && git push` does the same thing.

**Check it worked:** the `main` branch now shows `api/device.php` in the file list.

---

## 4. Put the new code on the server

Pick the option that matches how your server gets its code today.

### Option A — your server folder is a git checkout (has a hidden `.git` folder)

```bash
cd "<site folder>"
git status          # should say "nothing to commit" (config.local.php is ignored — that's normal)
git pull origin main
```

`config/config.local.php` is **not** touched by this — it's deliberately kept out of git, so your database password and bot token stay put.

### Option B — you upload files by SFTP / control panel

Upload these 7 files from the merged `main` branch (download the repo as a ZIP from GitHub: **Code → Download ZIP**), keeping the same folder structure:

```
api/device.php                                    (new)
api/repacks.php
api/telegram_callback.php
includes/Auth.php
migrations/010_api_tokens_and_device_codes.sql    (new)
public/link.html                                  (new)
config/config.php                                 (see warning)
```

> **Warning about `config/config.php`:** if you have **edited this file directly on the server** (instead of putting your settings in `config.local.php`), uploading the new one overwrites your edits. In that case don't upload it — just paste this block into your existing file, above the line `// Read-only export API`:
>
> ```php
> if (!defined('REPOST_COOLDOWN_MINUTES'))  define('REPOST_COOLDOWN_MINUTES',  30);
> if (!defined('DEVICE_CODE_TTL_MINUTES'))  define('DEVICE_CODE_TTL_MINUTES',  10);
> if (!defined('DEVICE_CODE_MAX_PER_IP'))   define('DEVICE_CODE_MAX_PER_IP',   10);
> ```

**Check it worked:** `ls "<site folder>/api/device.php"` exists (or you can see it in your SFTP client).

---

## 5. Check `APP_URL` (the #1 thing people miss)

When the GUI asks for a link code, the server builds the approval-page address from the setting `APP_URL`. The default is `http://localhost`, which would send you to a page that doesn't exist.

Open `<site folder>/config/config.local.php` and make sure it has your real public address, with `https://` and **no trailing slash**:

```php
define('APP_URL', 'https://your-testing-site.example');
```

(If that line isn't there, add it. Use the same address people type to reach the site.)

Optional — change the 30-minute redo window in the same file:

```php
define('REPOST_COOLDOWN_MINUTES', 30);
```

---

## 6. Run the database migration

The new code needs two new tables (`api_tokens` and `device_codes`). Your site already has an auto-migration that runs the first time anyone loads a page after new migration files appear — so usually this just happens. But check it, don't assume.

**Trigger it** by opening the site in your browser (any page), or from the server:

```bash
cd "<site folder>"
php migrate.php
```

**Check it worked** (server, using the DB values from `config.local.php`):

```bash
mysql -u DB_USER -p DB_NAME -e "SHOW TABLES LIKE 'api_tokens'; SHOW TABLES LIKE 'device_codes'; SELECT filename FROM migrations ORDER BY id DESC LIMIT 3;"
```

You should see both table names, and `010_api_tokens_and_device_codes.sql` in the list. In phpMyAdmin: open your database and look for the two tables.

**If the tables are missing:**
- Look at the PHP error log for a line starting `Auto-migration error`. The most common cause is the database user lacking permission to create tables — give it `CREATE` and `REFERENCES` on the database, then run `php migrate.php` again.
- If you can't use the migration runner, you can paste the contents of `migrations/010_api_tokens_and_device_codes.sql` into phpMyAdmin's **SQL** tab and run it. Then add a row so the runner doesn't try again: `INSERT INTO migrations (filename) VALUES ('010_api_tokens_and_device_codes.sql');`

---

## 7. Check nginx (three quick tests)

Run these **from any computer** (replace the address). They prove the new files are reachable and that the login header gets through to PHP.

**Test 1 — the approval page loads**

```bash
curl -I https://your-testing-site.example/link.html
```
Expect `HTTP/2 200` (or `HTTP/1.1 200`).

**Test 2 — the new API endpoint is routed**

```bash
curl -i "https://your-testing-site.example/api/device?action=tokens"
```
Expect a JSON reply like `{"error":"Authentication required."}` with status **401**. That's *good* — it means PHP ran `device.php` and correctly refused an anonymous request.

- If you get **404** or an HTML error page: your nginx config probably routes `/api/...` URLs by name. Find the `location` block that handles `/api/` (usually in `/etc/nginx/sites-enabled/` or `/etc/nginx/conf.d/`) and add `device` wherever the other endpoint names (`auth`, `repacks`, `claims`…) are listed. Then `sudo nginx -t && sudo systemctl reload nginx`.

**Test 3 — the token header reaches PHP**

```bash
curl -i -H "Authorization: Bearer 0000000000000000000000000000000000000000000000000000000000000000" \
  "https://your-testing-site.example/api/auth?action=user"
```
Expect **401** with `{"error":"Not authenticated."}` (a made-up token is correctly rejected). You can't fully prove the header arrives until you have a real token (section 10 does that), but if this call returns a normal JSON 401 the route is healthy.

> If a real token later gets "no longer valid" straight after linking, the `Authorization` header is being stripped. For nginx + PHP-FPM add this line inside your PHP `location` block, then reload nginx:
> ```nginx
> fastcgi_param HTTP_AUTHORIZATION $http_authorization;
> ```
> If your site sits behind Cloudflare, nothing special is needed for this, but see the troubleshooting table if you get a 403 HTML page.

---

## 8. Merge and release the GUI changes

### 8a. Merge

1. Go to <https://github.com/DeliciousMeatPop/AGrepackGUI> → **Pull requests** → **New pull request**.
2. **base: `main`**, **compare: `claude/charming-bardeen-ld3tse`** → **Create pull request**.
3. In **Files changed** you should see: `DMPRepackGUI.py`, `README.md`, `.gitignore`, and the new `agtesting.ini.example` (plus this guide).
4. **Merge pull request** → **Confirm merge**.

### 8b. Build and publish a new GUI version

Repackers using the `.exe` only get the new feature from a new release.

1. In the AGrepackGUI repo open the **Actions** tab → **Build & draft release** (left sidebar).
2. Click **Run workflow**. Make sure the branch dropdown says **`main`**.
3. Type the next version number — the current one is `1.1.5`, so use **`1.1.6`** (always three numbers, like `1.1.6`).
4. Click the green **Run workflow** button and wait a few minutes for the green tick.
5. Go to **Releases** (right side of the repo's front page). There's now a **Draft** release called `v1.1.6`. Open it, read it over, and click **Publish release**.

When repackers next open the GUI it offers to update itself.

> Running from source instead of the exe? Skip 8b — just `git pull` in the toolkit folder.

---

## 9. Set up each repacker's PC

Do this on **every PC that will post** (yours first). Everything is relative to the toolkit folder — the folder that holds `AG Repack GUI.exe` (or `DMPRepackGUI.py`), `rclone.exe` and `remotes.ini`.

### 9a. Get the new version

- **Exe users:** open the GUI and accept the update offer, *or* download `AG Repack GUI.zip` from the latest release and extract it over the old one.
- **Source users:** `git pull` in the toolkit folder.

You also need the new file **`agtesting.ini.example`** in the toolkit folder. If you update by downloading the repo ZIP / `git pull` you have it. If you only swapped the exe, grab the file from the repo and drop it next to the exe.

### 9b. Create `agtesting.ini`

Open **PowerShell** *in the toolkit folder* (File Explorer → click the address bar → type `powershell` → Enter) and run:

```powershell
Copy-Item agtesting.ini.example agtesting.ini
notepad agtesting.ini
```

(Command Prompt / batch equivalent: `copy agtesting.ini.example agtesting.ini` then `notepad agtesting.ini`.)

Edit it so it looks like this, with **your** site address:

```ini
[Site]
url = https://your-testing-site.example

[Types]
pc   = PC
pcvr = VR
```

Rules:
- `url` is just the site address. **No** `/api`, **no** trailing slash needed, and use **`https://`**.
- `[Types]` decides what type the site records for each upload destination: choosing **PC** in the upload dialog posts a `PC` repack, choosing **PCVR** posts a `VR` repack. If you'd rather PCVR posts as `BOTH`, change that line to `pcvr = BOTH`. Allowed values: `PC`, `VR`, `BOTH`.
- The file is ignored by git on purpose — it's yours alone.

**Check it worked:** start the GUI, open **Manual Steps** — you should see a new button **"10. Post to AGTesting…"**.

---

## 10. Test it with a throwaway release

> ⚠️ **Posting is real.** A successful post puts the release on the testing site **and announces it in the Telegram testing channel**. Tell the testers beforehand ("ignore anything called ZZ Test"), or test against a staging copy with a separate test channel. You'll delete the test entry at the end — deleting also removes the Telegram message.

### 10a. Make a fake package folder

In the toolkit folder create an empty folder with a made-up name and an unlikely build number. PowerShell:

```powershell
mkdir "ZZ Test Game v999001 -ARMGDDN"
```

The name **must** follow `Game Name vBUILDID -ARMGDDN` exactly (space before `v`, space before `-ARMGDDN`). The build ID must not already exist on the site.

### 10b. Post it and link this PC

1. In the GUI: **Manual Steps → 10. Post to AGTesting…**
2. Choose the `ZZ Test Game v999001 -ARMGDDN` folder.
3. "Is this a PCVR release?" → **No** (PC). "Does it have an update patch?" → **No**.
4. A box appears showing a code like **`K7M2-Q9XA`**, and your browser opens the site's **Link a tool** page.
   - If the site asks you to sign in, use the Telegram button as normal. It sends you straight back to the Link page afterwards.
   - **Check that the code on the page is the same as the one in the GUI box.** (This is the safety check: it stops someone else's request being approved by mistake.)
   - Click **Approve**.
5. Go back to the GUI. Within a few seconds the log shows:

   ```
   Linked - this PC can now post to AGTesting.
   Posted to AGTesting: ZZ Test Game v999001 -ARMGDDN
   ```

**Check it worked on the site:** refresh the testing site — `ZZ Test Game v999001 -ARMGDDN` is in the list as **Available**, and the testing channel got its announcement.

Back in the toolkit folder there's now a file called **`agtesting.token`**. That's this PC's key — treat it like a password (see section 14).

Optional proof the token works on its own (PowerShell, toolkit folder):

```powershell
$t = (Get-Content agtesting.token).Trim()
Invoke-RestMethod "https://your-testing-site.example/api/auth?action=user" -Headers @{ Authorization = "Bearer $t" }
```
It should print your user. If it says unauthorized, jump to the troubleshooting table.

### 10c. Test the "posted just now" rule

Run **Manual Steps → 10** again on the **same folder**. This time the log says:

```
Already posted 1 min ago - left as is. Nothing changed on AGTesting.
```

Nothing changes on the site — that's the accidental-double-post protection.

### 10d. Test the 30-minute redo rule

You can either wait 31 minutes and run step 10 again, or fast-forward the clock for that one release. On the server:

```bash
mysql -u DB_USER -p DB_NAME -e "
UPDATE repack_versions
   SET created_at = NOW() - INTERVAL 31 MINUTE
 WHERE repack_id = (SELECT id FROM repacks WHERE game_name = 'ZZ Test Game v999001 -ARMGDDN' AND is_patch = 0);"
```

(phpMyAdmin: paste the `UPDATE ...` part into the **SQL** tab.)

Now run **Manual Steps → 10** on the same folder again. The log says:

```
Already on AGTesting - reposted for retesting: ZZ Test Game v999001 -ARMGDDN
```

On the site the release is back to **Available**, its history shows a second version, and the Telegram announcement was replaced with a fresh one. Any existing test reports are kept; any tester's claim on it is released.

### 10e. Clean up

On the testing site, find `ZZ Test Game v999001 -ARMGDDN` and click **Delete** (you can delete your own repacks). Then delete the empty `ZZ Test Game v999001 -ARMGDDN` folder from your PC.

---

## 11. (Optional) Test with an update patch

Only needed if you post patches. The patch folder name must look like `Game Name v90-100_Update_Patch` (old build `90`, new build `100`, **numbers only**). Create a fake pair, e.g. `ZZ Patched v200 -ARMGDDN` and `ZZ Patched v150-200_Update_Patch`, run Manual Step 10 on the first, answer **Yes** to "update patch", and choose the second folder. The site gets both the repack and its patch entry, each with its own Telegram post. Delete both afterwards.

Reminder: a **redo** of an existing release doesn't add a new patch entry.

---

## 12. Using it for real

Nothing special to learn — it's part of the normal upload:

1. Make the repack as usual. When it's zipped and the **Upload to the testing remote** window appears, choose **Copy/Move** and **PC/PCVR** as before.
2. You'll see a new tick box: **Post to AGTesting when the upload finishes** (ticked by default). Leave it ticked.
3. Click **Upload**. The GUI uploads with rclone, and **only if the upload fully succeeded** it posts to the site. The log shows one of:

| Log line | Meaning |
|---|---|
| `Posted to AGTesting: <name>` | New release, now in the queue |
| `Already on AGTesting - reposted for retesting: <name>` | Redo (last posted 30+ min ago) — back in the queue |
| `Already posted N min ago - left as is.` | Double-post protection, nothing changed |
| `[ERROR] Not posted: build ID already used by "<other name>"` | Another release already has this build ID — check the name/build |

**Things worth knowing:**
- The **folder name is the release name.** It must be `Game Name vBUILDID -ARMGDDN`. If it isn't, the GUI refuses to post and tells you why (the upload itself is not affected).
- If you tick the box but click **Skip upload**, nothing posts. Use Manual Step 10 for that case.
- **If a post fails** (site down, no internet…) the upload is **not** repeated. Fix the problem, then **Manual Steps → 10. Post to AGTesting…** on the same folder. Nothing re-uploads.
- You can untick the box for any individual upload (for example while testing the upload side).

---

## 13. Day-to-day admin

| I want to… | Do this |
|---|---|
| **Add a new repacker's PC** | They do section 9, then their first post walks them through the one-time link. They need the repacker or admin role. |
| **See which PCs are linked to me** | Sign in, then open `https://your-testing-site.example/link.html` — it lists your linked tools with "last used" times. |
| **Cut off a PC (lost laptop, someone left)** | Open `/link.html` as that user and click **Revoke**. Or remove the person from the repackers channel — posting stops within about 10 minutes, no revoke needed. |
| **Re-link a PC** | Delete `agtesting.token` from the toolkit folder (or revoke it on the site). The next post starts the link again. |
| **Change the 30 minutes** | `define('REPOST_COOLDOWN_MINUTES', 45);` in `config/config.local.php` on the server. No GUI change needed. |
| **Change what type PCVR posts as** | Edit `[Types]` in that PC's `agtesting.ini`. |
| **Point at a different site** | Change `url` in `agtesting.ini`, then delete `agtesting.token` (tokens only work on the site that issued them). |

Tokens stay valid until revoked, and are checked **live** on every post: if someone is removed from the channels or deleted from the site, their token stops working immediately.

---

## 14. Security notes (short and important)

- **`agtesting.token` is a password.** Anyone with that file can post as that repacker. Don't zip it into releases, upload it, or paste it in chat. It's in `.gitignore` so it can't be committed by accident. If it leaks, **Revoke** it on `/link.html`.
- **The site stores only a hash of each token**, never the token itself, so a database leak doesn't expose working tokens.
- **A token can't create more tokens.** Only a person signed in through the browser can approve a link.
- **Always check the code** on the approval page matches the GUI before clicking Approve. If you didn't just start a link, click **Reject**.
- **Use `https://` only.** The token travels in a header on every post.
- The link request endpoint is rate-limited (10 per IP per 10 minutes) and codes expire after 10 minutes.

---

## 15. Troubleshooting

| What you see | Why | Fix |
|---|---|---|
| No "Post to AGTesting" box in the upload window | `agtesting.ini` is missing, misnamed, or has no valid `url` | It must be named exactly `agtesting.ini` (not `.ini.txt` — turn on "File name extensions" in Explorer), sit next to the exe, and have `url = https://...` under `[Site]` |
| `Skipped - agtesting.ini not found next to the program` | Same as above | Same fix |
| `Couldn't reach https://…: …` + a Retry box | No internet, wrong address, certificate problem, or firewall | Open the `url` in a browser on that PC. Fix the address/connection and click Retry. If it's hopeless, cancel and use Manual Step 10 later |
| Browser opens a page that says link code invalid/expired | Waited over 10 minutes, or started twice | Close it and start the post again to get a fresh code |
| Browser opens `localhost` or the wrong site | `APP_URL` on the server is wrong | Section 5 |
| After Telegram login you land on the home page instead of the Link page | The short-lived redirect cookie was blocked | Open the code link again (the GUI log prints it: "Approval page …"). You're signed in now, so it will load normally |
| "Only repackers and admins can link a posting tool" | Your account is a tester | Get added to the staff **and** repackers channels (or have an admin account) |
| `The saved AGTesting link is no longer valid.` then it re-links by itself | Token was revoked or the account was removed | Normal — approve again. If it happens **every time right after linking**, the `Authorization` header is being stripped: see the `fastcgi_param` note in section 7 |
| `AGTesting says this account can't post (it needs the repacker or admin role)` | Linked fine, but you've left the staff/repackers channels | Rejoin them; the role refreshes within ~10 minutes |
| `[ERROR] "<name>" is not in the form "Game Name vBUILDID -ARMGDDN"` | Folder name wrong | Rename the package folder exactly: `Game Name v12345 -ARMGDDN` |
| `Not posted: build ID already used by "<other name>"` | Another release has the same build ID but a different name | Check for a typo in the name; if it really is the same game, name it identically so it counts as a redo |
| `Too many link requests` (HTTP 429) | More than 10 link attempts from one IP in 10 minutes | Wait 10 minutes |
| Blocked with an HTML "Access denied / challenge" page, HTTP 403 | A firewall/bot-protection rule (e.g. Cloudflare) is blocking non-browser requests | Add an exception for `/api/device` and `/api/repacks`, or lower the bot-fight level for those paths |
| Linked and posted, but nothing in the Telegram channel | The post worked but Telegram failed (the site logs it and carries on) | Check the PHP error log for `Telegram post failed`; verify the bot token and channel IDs |
| Reposted when you expected "already posted" | The last version was more than 30 minutes ago (the clock is on the **server**, from the last version row) | Working as designed; raise `REPOST_COOLDOWN_MINUTES` if you want a longer window |
| Everything works but you want to see what the server did | — | `tail` the PHP / nginx error log on the server while you post |

---

## 16. Undoing it

Nothing here changes existing data, so rolling back is safe.

- **Stop the GUI posting:** delete `agtesting.ini` on that PC. The box disappears and uploads behave exactly as before.
- **Remove it from the server:** on GitHub open the merged pull request and click **Revert** (it creates a new PR that undoes it), merge that, and deploy as in section 4. The two extra tables can stay (they're harmless). To remove them as well:

  ```sql
  DROP TABLE api_tokens, device_codes;
  DELETE FROM migrations WHERE filename = '010_api_tokens_and_device_codes.sql';
  ```
  then delete the file `<site folder>/.migrations_applied`.
- **Worst case:** restore the backups from section 2.

---

## Appendix A — what changed, file by file

**AGTesting (server)**

| File | Purpose |
|---|---|
| `migrations/010_api_tokens_and_device_codes.sql` | `api_tokens` (hashed tokens, one row per linked PC) and `device_codes` (short-lived link requests) |
| `api/device.php` | `start` / `poll` (the GUI), `info` / `approve` / `deny` (the approval page), `tokens` / `revoke` (the list on the page) |
| `public/link.html` | The page you see in the browser: shows the code, Approve/Reject, and your linked tools with Revoke |
| `includes/Auth.php` | `getUser()` now also accepts `Authorization: Bearer <token>` (or `X-API-Token`). Roles and channel membership are still checked on every request |
| `api/repacks.php` | New `?action=submit`: unknown name → create; known and posted < 30 min ago → ignore; known and older → repost through the normal replace flow. Age comes from the newest `repack_versions` row, measured by the database clock |
| `api/telegram_callback.php` | After Telegram login, honours a short-lived `login_redirect` cookie so you return to the Link page; blocks `//` and backslash redirects |
| `config/config.php` | `REPOST_COOLDOWN_MINUTES` (30), `DEVICE_CODE_TTL_MINUTES` (10), `DEVICE_CODE_MAX_PER_IP` (10) |

**AGrepackGUI (Windows program)**

| File | Purpose |
|---|---|
| `DMPRepackGUI.py` | Reads `agtesting.ini`, does the link flow, posts after upload, adds the tick box and Manual Step 10. Uses only Python's built-in `urllib` — no new installs |
| `agtesting.ini.example` | Template for `agtesting.ini` |
| `.gitignore` | Keeps `agtesting.ini` and `agtesting.token` out of git |
| `README.md` | Short version of this guide |

## Appendix B — poking the API by hand (PowerShell, toolkit folder)

Handy for debugging. `$t` is the token from `agtesting.token`.

```powershell
$site = "https://your-testing-site.example"
$t = (Get-Content agtesting.token).Trim()
$h = @{ Authorization = "Bearer $t" }

# Who does the site think I am?
Invoke-RestMethod "$site/api/auth?action=user" -Headers $h

# What tools are linked to me?
Invoke-RestMethod "$site/api/device?action=tokens" -Headers $h

# Post (or redo) a release exactly like the GUI does
Invoke-RestMethod "$site/api/repacks?action=submit" -Method Post -Headers $h `
  -ContentType "application/json" `
  -Body (@{ game_name = "Some Game v12345 -ARMGDDN"; type = "PC" } | ConvertTo-Json)
```

The reply to the last call includes `"outcome": "created"`, `"reposted"` or `"duplicate"`.
