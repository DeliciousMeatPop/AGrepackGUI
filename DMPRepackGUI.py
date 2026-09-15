#!/usr/bin/env python3
"""
DMPRepack GUI  –  ARMGDDN Games Repack Tool
A graphical interface replacing Repack.bat and all PS1 scripts.

Requirements: Python 3.8+  (tkinter is bundled with standard Windows Python)
Usage       : python DMPRepackGUI.py
              or double-click if .py files open with Python on your machine
"""

import os
import re
import sys
import time
import shutil
import zipfile
import subprocess
import threading
import webbrowser
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
from pathlib import Path

# ─── Version / update check ──────────────────────────────────────────────────
# This string is the source of truth.  The "Build & draft release" GitHub
# Actions workflow rewrites it from the version you type when you run it, then
# commits it back here — so you normally don't edit it by hand.  make_version_file.py
# reads it to stamp the exe, and the app compares it against the latest GitHub
# release on launch.
__version__ = "1.1.0"
GITHUB_REPO = "DeliciousMeatPop/AGrepackGUI"


# ─── Resolve base directory ──────────────────────────────────────────────────
if getattr(sys, "frozen", False):          # PyInstaller single-file exe
    BASE_DIR = Path(sys.executable).parent
else:
    BASE_DIR = Path(__file__).resolve().parent

RESOURCE_DIR   = BASE_DIR / "Resource"
SETUP_DIR      = BASE_DIR / "Setup"
COMPRESSOR     = BASE_DIR / "COMPRESSOR"
SAVE_DIR       = RESOURCE_DIR / "Save"
DLL_DIR        = RESOURCE_DIR / "DLL"
SETTINGS_INI   = BASE_DIR / "settings.ini"
SCRIPT_ISS     = BASE_DIR / "Script.iss"
SEVEN_ZIP      = BASE_DIR / "7z.exe"
CONVERSION_DIR = COMPRESSOR / "Conversion_Output" / "CONVERSION"
SETUP_FILES    = COMPRESSOR / "Setup_Files"
ISCC           = BASE_DIR / "Resources" / "IS_Files" / "ISCC.exe"
COMPIL32       = BASE_DIR / "Resources" / "IS_Files" / "Compil32Ex.exe"
ARC_EXE        = COMPRESSOR / "Resources" / "Win64" / "Arc.exe"
APP_ICON       = BASE_DIR / "setup.ico"

INI_TEMPLATES = {
    "PC":          RESOURCE_DIR / "2.ini",
    "VR":          RESOURCE_DIR / "1.ini",
    "VR Optional": RESOURCE_DIR / "3.ini",
}

COMPRESSION_BATS = {
    "12": RESOURCE_DIR / "12.bat",
    "8":  RESOURCE_DIR / "8.bat",
    "4":  RESOURCE_DIR / "4.bat",
    "0":  RESOURCE_DIR / "store.bat",
}

# ─── Colour palette ──────────────────────────────────────────────────────────
BG      = "#111827"   # main window bg
PANEL   = "#1f2937"   # card / panel bg
BORDER  = "#374151"   # subtle divider
ACCENT  = "#6366f1"   # indigo primary
FG      = "#f9fafb"   # near-white text
FG2     = "#9ca3af"   # muted / label text
ENTRY   = "#0f172a"   # entry background
BTN     = "#374151"   # default button
SUCCESS = "#22c55e"   # green
DANGER  = "#ef4444"   # red
WARN    = "#f59e0b"   # amber


# ═══════════════════════════════════════════════════════════════════════════
#  INI helpers
# ═══════════════════════════════════════════════════════════════════════════

def ini_read(path: Path) -> list:
    if not path.exists():
        return []
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    return raw.decode("utf-8", errors="replace").splitlines(keepends=True)


def ini_write(path: Path, lines: list):
    # Write UTF-8 WITHOUT BOM — GetPrivateProfileString / ISPP ReadIni
    # reads the BOM bytes as literal text and corrupts the first section header.
    content = "".join(lines)
    content = content.replace("\r\n", "\n").replace("\r", "\n").replace("\n", "\r\n")
    path.write_bytes(content.encode("utf-8"))


def ini_set(lines: list, key: str, value: str, occurrence: int = 0) -> list:
    """Replace the (occurrence)-th `key=...` line.  Appends if not found."""
    prefix = key.lower() + "="
    count = 0
    for i, line in enumerate(lines):
        if line.strip().lower().startswith(prefix):
            if count == occurrence:
                lines[i] = f"{key}={value}\n"
                return lines
            count += 1
    lines.append(f"{key}={value}\n")
    return lines


def ini_get(lines: list, key: str, default: str = "", occurrence: int = 0) -> str:
    prefix = key.lower() + "="
    count = 0
    for line in lines:
        s = line.strip()
        if s.lower().startswith(prefix):
            if count == occurrence:
                return s.split("=", 1)[1].strip()
            count += 1
    return default


def ini_get_in_section(lines: list, section: str, key: str, default: str = "") -> str:
    """Read the first key=value within a specific [Section] block."""
    in_target = False
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            in_target = (stripped[1:-1].strip().lower() == section.lower())
            continue
        if in_target and stripped.lower().startswith(key.lower() + "="):
            return stripped.split("=", 1)[1].strip()
    return default


def parse_exe_sections(lines: list) -> list:
    """
    Return a list of dicts, one per [ExecutableN] block found in the file.
    Handles duplicate section names (as used in the VR Optional template).
    """
    sections = []
    current  = None
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            sec = stripped[1:-1].strip()
            if sec.lower().startswith("executable"):
                current = {}
                sections.append(current)
            else:
                current = None
        elif (current is not None
              and "=" in stripped
              and not stripped.startswith(";")
              and not stripped.startswith("//")):
            k, _, v = stripped.partition("=")
            current[k.strip().lower()] = v.strip()
    return sections


def ini_set_in_section(lines: list, section: str, key: str, value: str) -> list:
    """Replace key=value within a specific named [Section] block only."""
    in_target = False
    for i, line in enumerate(lines):
        stripped = line.strip()
        if stripped.startswith("[") and stripped.endswith("]"):
            in_target = (stripped[1:-1].strip().lower() == section.lower())
            continue
        if in_target and stripped.lower().startswith(key.lower() + "="):
            lines[i] = f"{key}={value}\r\n"
            return lines
    return lines


def ini_uncomment_block(lines: list, header: str) -> list:
    """Remove leading ; from a commented-out [Section] block."""
    result = []
    in_block = False
    header_lo = header.strip().lower()
    for line in lines:
        stripped = line.strip()
        no_semi = stripped.lstrip(";").strip()
        if no_semi.lower() == header_lo:
            in_block = True
            result.append(no_semi + "\n")
            continue
        if in_block:
            if stripped.startswith(";") and no_semi.startswith("["):
                in_block = False
                result.append(no_semi + "\n")
                continue
            if stripped.startswith(";"):
                result.append(no_semi + "\n")
                continue
        result.append(line)
    return result


# ═══════════════════════════════════════════════════════════════════════════
#  Repacker identity
# ═══════════════════════════════════════════════════════════════════════════

def get_repacker() -> str:
    p = SAVE_DIR / "repacker.txt"
    return p.read_text(encoding="utf-8").strip() if p.exists() else ""


def save_repacker(name: str):
    SAVE_DIR.mkdir(parents=True, exist_ok=True)
    (SAVE_DIR / "repacker.txt").write_text(name + "\n", encoding="utf-8")


# ═══════════════════════════════════════════════════════════════════════════
#  Worker functions  (pure Python, no PS1 needed)
# ═══════════════════════════════════════════════════════════════════════════

def sanitize_name(name: str) -> str:
    name = re.sub(r"['\?]", "", name)
    return re.sub(r"\s+", " ", name).strip()


def dir_size_str(folder: Path) -> str:
    """Return a human-readable size string for a directory (e.g. '14.23 GB')."""
    total = sum(f.stat().st_size for f in folder.rglob("*") if f.is_file())
    for unit in ("bytes", "KB", "MB", "GB", "TB"):
        if total < 1024 or unit == "TB":
            return f"{total:.2f} {unit}" if unit != "bytes" else f"{total} bytes"
        total /= 1024
    return ""


def _has_console() -> bool:
    """True if this process owns a console window.

    A --console PyInstaller build (and a plain `python` run) always has one; a
    --windowed build does not, and there its child processes need their own
    console plus valid std handles to launch reliably.
    """
    if os.name != "nt":
        return True
    try:
        import ctypes
        return ctypes.windll.kernel32.GetConsoleWindow() != 0
    except Exception:
        return sys.stdout is not None


def write_temp(filename: str, value: str):
    import tempfile
    p = Path(tempfile.gettempdir()) / filename
    p.write_text(value + " \n", encoding="utf-8")


# ── Pre-processing ───────────────────────────────────────────────────────────

def work_copy_finish_bmp(log) -> None:
    """Copy Welcome.bmp → Finish.bmp in Setup/ if Welcome exists but Finish doesn't."""
    welcome = SETUP_DIR / "Welcome.bmp"
    finish  = SETUP_DIR / "Finish.bmp"
    if welcome.exists() and not finish.exists():
        shutil.copy2(str(welcome), str(finish))
        log("  Finish.bmp created from Welcome.bmp")
    elif finish.exists():
        log("  Finish.bmp already exists — skipped")
    else:
        log("[WARN] Welcome.bmp not found in Setup/ — Finish.bmp not created")


def work_rename_originals(game_dir: str, log) -> bool:
    folder = Path(game_dir)
    if not folder.is_dir():
        log(f"[ERROR] Directory not found: {game_dir}")
        return False
    pattern = re.compile(r"_o(?=\.[^.]+$)|\s*\(Original\)", re.IGNORECASE)
    renamed = 0
    for f in folder.rglob("*"):
        if f.is_file() and pattern.search(f.stem):
            new_name = pattern.sub("", f.stem) + ".AG"
            f.rename(f.parent / new_name)
            log(f"  Renamed: {f.name}  →  {new_name}")
            renamed += 1
    log(f"  {renamed} file(s) renamed." if renamed else "  No matching files found.")
    return True


def work_sort_dlc(game_dir: str, log) -> bool:
    folder = Path(game_dir)
    matches = list(folder.rglob("DLC.txt"))
    if not matches:
        log("[ERROR] DLC.txt not found in game directory.")
        return False
    dlc_path = matches[0]
    content = dlc_path.read_text(encoding="utf-8").splitlines()

    def fmt(line):
        line = re.sub(
            r"^(\d+)\s+(.*?)\s+(?:\(.*?\))?\s+(?:last month|\d+\s+\w+\s+ago)",
            r"\1=\2", line)
        line = re.sub(r"^(\d+)\s+(\w)", r"\1=\2", line)
        return line

    modified = [fmt(l) for l in content]
    sorted_c = sorted(
        modified,
        key=lambda l: int(re.match(r"(\d+)", l).group(1))
        if re.match(r"(\d+)", l) else 0
    )
    dlc_path.write_text("\n".join(sorted_c), encoding="utf-8")
    log(f"  DLC.txt sorted: {dlc_path}")
    return True


# ── Settings.ini ─────────────────────────────────────────────────────────────

def work_build_settings(game_type: str, fields: dict, log) -> bool:
    template = INI_TEMPLATES.get(game_type)
    if not template or not template.exists():
        log(f"[ERROR] Template not found: {template}")
        return False

    lines = ini_read(template)
    repacker = fields.get("repacker") or get_repacker()
    name     = fields["name"]

    # Common top-level keys
    lines = ini_set(lines, "Name",          name)
    lines = ini_set(lines, "APPID",         fields.get("appid", ""))
    lines = ini_set(lines, "Buildversion",  fields.get("build", ""))
    lines = ini_set(lines, "Size",          fields.get("size", ""))
    lines = ini_set(lines, "REPACKER",      repacker)
    lines = ini_set(lines, "CompactMode",   "1" if fields.get("compact")    else "0")
    lines = ini_set(lines, "RunAppAsAdmin", "1" if fields.get("admin")      else "0")

    infobefore_val = "1" if fields.get("infobefore") else "0"
    enablebat_val  = "1" if fields.get("enablebat")  else "0"

    if game_type == "PC":
        lines = ini_set(lines, "ShortcutName", name,                    0)
        lines = ini_set(lines, "Exe",          fields.get("exe1", ""),  0)
        lines = ini_set(lines, "ExeParam",     fields.get("exe1p", ""), 0)
        lines = ini_set_in_section(lines, "InfoBefore", "Enable", infobefore_val)
        lines = ini_set_in_section(lines, "Batch",      "Enable", enablebat_val)
        if fields.get("enablebat"):
            lines = ini_set_in_section(lines, "Batch", "BatchFile", fields.get("batfile", ""))

    elif game_type == "VR":
        lines = ini_set(lines, "ShortcutName", f"{name} (SteamVR)",     0)
        lines = ini_set(lines, "Exe",          fields.get("exe1", ""),  0)
        lines = ini_set(lines, "ExeParam",     fields.get("exe1p", ""), 0)
        lines = ini_set(lines, "ShortcutName", f"{name} (VD)",          1)
        lines = ini_set(lines, "Exe",          fields.get("exe2", ""),  1)
        lines = ini_set(lines, "ExeParam",     fields.get("exe2p", ""), 1)
        if fields.get("meta"):
            lines = ini_uncomment_block(lines, "[Executable3]")
            lines = ini_set(lines, "ShortcutName", f"{name} (Meta)",    2)
            lines = ini_set(lines, "Exe",          fields.get("exe3", ""), 2)
            lines = ini_set(lines, "ExeParam",     fields.get("exe3p",""), 2)
        lines = ini_set_in_section(lines, "InfoBefore", "Enable", infobefore_val)
        lines = ini_set_in_section(lines, "Batch",      "Enable", enablebat_val)
        if fields.get("enablebat"):
            lines = ini_set_in_section(lines, "Batch", "BatchFile", fields.get("batfile", ""))

    elif game_type == "VR Optional":
        (BASE_DIR / "vroptional.txt").write_text("1", encoding="utf-8")
        lines = ini_set(lines, "ShortcutName", f"{name} (Flat)",        0)
        lines = ini_set(lines, "Exe",          fields.get("exe1", ""),  0)
        lines = ini_set(lines, "ExeParam",     fields.get("exe1p", ""), 0)
        lines = ini_set(lines, "ShortcutName", f"{name} (SteamVR)",     1)
        lines = ini_set(lines, "Exe",          fields.get("exe2", ""),  1)
        lines = ini_set(lines, "ExeParam",     fields.get("exe2p", ""), 1)
        lines = ini_set(lines, "ShortcutName", f"{name} (VD)",          2)
        lines = ini_set(lines, "Exe",          fields.get("exe3", ""),  2)
        lines = ini_set(lines, "ExeParam",     fields.get("exe3p", ""), 2)
        if fields.get("meta"):
            lines = ini_uncomment_block(lines, "[Executable3]")
            lines = ini_set(lines, "ShortcutName", f"{name} (Meta)",    3)
            lines = ini_set(lines, "Exe",          fields.get("exe4", ""), 3)
            lines = ini_set(lines, "ExeParam",     fields.get("exe4p",""), 3)
        lines = ini_set_in_section(lines, "InfoBefore", "Enable", infobefore_val)
        lines = ini_set_in_section(lines, "Batch",      "Enable", enablebat_val)
        if fields.get("enablebat"):
            lines = ini_set_in_section(lines, "Batch", "BatchFile", fields.get("batfile", ""))
    else:
        log(f"[ERROR] Unknown game type: {game_type}")
        return False

    ini_write(SETTINGS_INI, lines)
    log(f"  settings.ini written for [{game_type}]: {name}")
    return True


# ── Compile ──────────────────────────────────────────────────────────────────

def work_compile_gui(log) -> bool:
    """Open Inno Setup IDE to compile (non-blocking, user-facing)."""
    if COMPIL32.exists():
        subprocess.Popen([str(COMPIL32), "/CC", str(SCRIPT_ISS)],
                         cwd=str(BASE_DIR))
        log("  Inno Setup compiler launched. Close its window when done.")
        return True
    bat = BASE_DIR / "Compile_Script.bat"
    if bat.exists():
        subprocess.Popen(str(bat), cwd=str(BASE_DIR), shell=True)
        log("  Compile_Script.bat launched.")
        return True
    log("[ERROR] No compiler found (Compil32Ex.exe / Compile_Script.bat).")
    return False


def work_compile_blocking(log) -> bool:
    """Use ISCC.exe (CLI) for a blocking compile in the full-run flow."""
    if ISCC.exists():
        log("  Compiling with ISCC.exe (blocking)...")
        r = subprocess.run([str(ISCC), str(SCRIPT_ISS)], cwd=str(BASE_DIR),
                           capture_output=True, text=True)
        for line in r.stdout.splitlines():
            log("    " + line)
        for line in r.stderr.splitlines():
            log("    " + line)
        if r.returncode == 0:
            log("  Compilation successful.")
            return True
        log(f"[ERROR] ISCC exited with code {r.returncode}")
        return False
    # Fallback: launch GUI compiler and ask user to confirm
    log("  ISCC.exe not found — falling back to GUI compiler.")
    work_compile_gui(log)
    return True   # caller shows a dialog


# ── Compress ─────────────────────────────────────────────────────────────────

def work_compress(preset: str, game_dir: str, log) -> bool:
    bat = COMPRESSION_BATS.get(preset)
    if not bat or not bat.exists():
        log(f"[ERROR] Compression bat not found for preset {preset}: {bat}")
        return False

    # The batch reads dir.tmp / directory.tmp from %TEMP% and writes all of its
    # output underneath BASE_DIR (COMPRESSOR\...).  If the install folder is not
    # writable — e.g. installed under Program Files and launched without admin —
    # every write below fails and the compression silently produces nothing.
    # Catch that here with a clear message instead of a mystery "no data.bin".
    try:
        CONVERSION_DIR.mkdir(parents=True, exist_ok=True)
        (COMPRESSOR / "Conversion_Output").mkdir(parents=True, exist_ok=True)
        probe = COMPRESSOR / "Conversion_Output" / ".write_test"
        probe.write_bytes(b"")
        probe.unlink()
    except OSError as e:
        log(f"[ERROR] Cannot write to the working folder: {e}")
        log(f"        Location: {COMPRESSOR}")
        log("        Run the app as administrator, or install it somewhere writable")
        log("        (not inside Program Files).")
        return False

    write_temp("dir.tmp",       game_dir)
    write_temp("directory.tmp", str(BASE_DIR))
    write_temp("preset.tmp",    preset)
    log(f"  Running compression preset {preset} — this will take a while...")
    log("  (watch the CMD window for Arc progress)")

    # Clear any stale Data.bin so the success check below can't be fooled by a
    # leftover from a previous run.
    data_bin = CONVERSION_DIR / "Data.bin"
    try:
        if data_bin.exists():
            data_bin.unlink()
    except OSError:
        pass

    # Write a temp bat with PAUSE removed so the window closes automatically.
    bat_lines = bat.read_bytes().decode("utf-8", errors="replace").splitlines(keepends=True)
    no_pause  = "".join(ln for ln in bat_lines if ln.strip().upper() != "PAUSE")
    tmp_bat   = bat.parent / f"_tmp_{bat.name}"
    try:
        tmp_bat.write_bytes(no_pause.encode("utf-8"))
    except OSError as e:
        log(f"[ERROR] Cannot write compression helper script: {e}")
        log(f"        Location: {tmp_bat.parent}")
        log("        Run the app as administrator, or install it somewhere writable.")
        return False

    # In a --windowed (no-console) PyInstaller build the process has no console
    # and its std handles are invalid, which can make the child cmd abort the
    # moment it launches.  Give the child its own console and a valid stdin so
    # it runs the same way it does under the --console build.
    run_kwargs = {"cwd": str(BASE_DIR), "shell": True}
    if os.name == "nt" and not _has_console():
        run_kwargs["creationflags"] = getattr(subprocess, "CREATE_NEW_CONSOLE", 0)
        run_kwargs["stdin"] = subprocess.DEVNULL

    try:
        r = subprocess.run(str(tmp_bat), **run_kwargs)
    finally:
        try:
            tmp_bat.unlink()
        except OSError:
            pass

    if r.returncode != 0:
        log(f"[ERROR] Compression failed (exit code {r.returncode}).")
        return False

    # Verify the batch actually produced Data.bin.  A non-zero-length file is
    # the only reliable signal that Arc ran to completion — the exit code alone
    # is not trustworthy when the paths handed to the batch were empty/unreadable.
    if not data_bin.exists() or data_bin.stat().st_size == 0:
        log(f"[ERROR] Compression finished but Data.bin was not produced: {data_bin}")
        log("        Common causes:")
        log("          • The game directory was empty, wrong, or unreadable.")
        log("          • The install folder is not writable (see Program Files / admin note above).")
        log("          • The game path contains non-English characters.")
        return False

    log("  Compression complete.")
    return True


# ── Records ──────────────────────────────────────────────────────────────────

def work_records(preset: str, log) -> bool:
    data_bin = CONVERSION_DIR / "data.bin"
    if not data_bin.exists():
        log(f"[ERROR] data.bin not found: {data_bin}")
        return False
    template = DLL_DIR / "recordstemplate.ini"
    if not template.exists():
        log(f"[ERROR] recordstemplate.ini not found: {template}")
        return False

    size_bytes = data_bin.stat().st_size
    formatted  = "{:,}".format(size_bytes).replace(",", ".")

    lines = ini_read(template)
    lines = ini_set(lines, "Size", f"{formatted} bytes")
    ini_write(template, lines)

    dest = DLL_DIR / preset / "Records.ini"
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(template, dest)
    log(f"  Records.ini written ({formatted} bytes)  →  {dest}")
    return True


# ── Create DLL ───────────────────────────────────────────────────────────────

def work_create_dll(preset: str, log) -> bool:
    if not ARC_EXE.exists():
        log(f"[ERROR] Arc.exe not found: {ARC_EXE}")
        return False
    src_dir = DLL_DIR / preset
    if not src_dir.is_dir():
        log(f"[ERROR] DLL source folder not found: {src_dir}")
        return False

    tmp = BASE_DIR / "temp"
    tmp.mkdir(exist_ok=True)

    cmd = [str(ARC_EXE), "a", "-ep1", "-r", "-ed", "-s",
           f"-w{tmp}", "-mx", "AGRepackInstaller.dll",
           str(src_dir / "*")]
    log("  Building AGRepackInstaller.dll with Arc...")
    subprocess.run(cmd, cwd=str(BASE_DIR))

    created = BASE_DIR / "AGRepackInstaller.dll"
    dest    = CONVERSION_DIR / "AGRepackInstaller.dll"
    if created.exists():
        CONVERSION_DIR.mkdir(parents=True, exist_ok=True)
        shutil.move(str(created), str(dest))
        log(f"  AGRepackInstaller.dll  →  {dest}")
    else:
        log("[ERROR] AGRepackInstaller.dll was not produced by Arc.")
        return False

    # Remove Records.ini from preset dir (it's been consumed)
    rec = src_dir / "Records.ini"
    if rec.exists():
        rec.unlink()

    shutil.rmtree(tmp, ignore_errors=True)
    return True


# ── Merge DLL into EXE ───────────────────────────────────────────────────────

def work_internal_dll(log, blocking_compile: bool = False) -> bool:
    dll_src = CONVERSION_DIR / "AGRepackInstaller.dll"
    if not dll_src.exists():
        log(f"[ERROR] AGRepackInstaller.dll not found: {dll_src}")
        return False

    # VR Optional: back up DLL + Data.bin before consuming them
    optional = BASE_DIR / "vroptional.txt"
    if optional.exists():
        SAVE_DIR.mkdir(parents=True, exist_ok=True)
        shutil.copy2(str(dll_src), str(SAVE_DIR / "AGRepackInstaller.dll"))
        data_bin = CONVERSION_DIR / "Data.bin"
        if data_bin.exists():
            shutil.copy2(str(data_bin), str(SAVE_DIR / "Data.bin"))
        log("  VR Optional: DLL + Data.bin backed up to Save/")

    # Remove Autorun.inf if present
    autorun = CONVERSION_DIR / "Autorun.inf"
    if autorun.exists():
        autorun.unlink()
        log("  Autorun.inf removed.")

    # Move DLL next to Script.iss
    dll_beside = BASE_DIR / "AGRepackInstaller.dll"
    shutil.move(str(dll_src), str(dll_beside))

    # Enable ;#define InternalDLL in Script.iss
    iss_raw = SCRIPT_ISS.read_bytes()
    bom = iss_raw[:3] == b"\xef\xbb\xbf"
    iss_body = iss_raw[3:] if bom else iss_raw
    lines = iss_body.decode("utf-8").splitlines(keepends=True)
    for i, ln in enumerate(lines):
        if "InternalDLL" in ln and ln.strip().startswith(";"):
            eol = "\r\n" if ln.endswith("\r\n") else "\n"
            lines[i] = f"#define InternalDLL{eol}"
            break
    iss_out = "".join(lines).encode("utf-8")
    SCRIPT_ISS.write_bytes((b"\xef\xbb\xbf" if bom else b"") + iss_out)
    log("  InternalDLL enabled — compiling...")

    if blocking_compile:
        compile_ok = work_compile_blocking(log)
    else:
        compile_ok = work_compile_gui(log)
        time.sleep(2)   # brief pause so the compile has a moment to start

    # Re-disable InternalDLL
    iss_raw2 = SCRIPT_ISS.read_bytes()
    bom2 = iss_raw2[:3] == b"\xef\xbb\xbf"
    iss_body2 = iss_raw2[3:] if bom2 else iss_raw2
    lines2 = iss_body2.decode("utf-8").splitlines(keepends=True)
    for i, ln in enumerate(lines2):
        if "InternalDLL" in ln and not ln.strip().startswith(";"):
            eol2 = "\r\n" if ln.endswith("\r\n") else "\n"
            lines2[i] = f";#define InternalDLL{eol2}"
            break
    iss_out2 = "".join(lines2).encode("utf-8")
    SCRIPT_ISS.write_bytes((b"\xef\xbb\xbf" if bom2 else b"") + iss_out2)

    # Move DLL to Setup folder for archiving
    dll_setup = SETUP_DIR / "AGRepackInstaller.dll"
    if dll_beside.exists():
        shutil.move(str(dll_beside), str(dll_setup))

    # Move compiled EXE into CONVERSION dir
    exe_src  = SETUP_FILES / "AGRepackInstaller.exe"
    exe_dest = CONVERSION_DIR / "AGRepackInstaller.exe"
    if exe_src.exists():
        shutil.move(str(exe_src), str(exe_dest))
        log(f"  AGRepackInstaller.exe  →  {exe_dest}")
    else:
        log("[WARN] AGRepackInstaller.exe not found in Setup_Files/ after compile.")

    log("  DLL merge complete.")
    return compile_ok


# ── Repack log dump ──────────────────────────────────────────────────────────

def save_repack_log(log_text: str, log) -> None:
    """Write the session log to Background/repack_log.txt so it gets bundled
    into the art archive by work_archive_art()."""
    bg_dir = SETUP_DIR / "Background"
    bg_dir.mkdir(parents=True, exist_ok=True)
    out = bg_dir / "repack_log.txt"
    out.write_text(log_text, encoding="utf-8")
    log(f"  Repack log saved: {out.name}")


# ── Zip & Name ───────────────────────────────────────────────────────────────

def work_zip_and_name(log) -> bool:
    if not SETTINGS_INI.exists():
        log("[ERROR] settings.ini not found.")
        return False
    if not SEVEN_ZIP.exists():
        log(f"[ERROR] 7z.exe not found: {SEVEN_ZIP}")
        return False

    lines  = ini_read(SETTINGS_INI)
    name   = sanitize_name(ini_get(lines, "Name", "Game"))
    appid  = ini_get(lines, "APPID", "")
    build  = ini_get(lines, "Buildversion", "")
    admin  = ini_get(lines, "RunAppAsAdmin", "0")

    optional = BASE_DIR / "vroptional.txt"
    if optional.exists():
        name += " VR"

    group = "-ARMGDDN"
    if admin.strip() == "1":
        group += " + OFME"

    zip_name    = f"{name} v{build} {group}.7z"
    folder_name = f"{name} v{build} {group}"
    out_folder  = BASE_DIR / folder_name
    out_folder.mkdir(exist_ok=True)

    files = [f for f in CONVERSION_DIR.iterdir() if f.is_file()]
    total = sum(f.stat().st_size for f in files)

    split_flag = ["-v5000M"] if total > 10 * 1024 ** 3 else []
    cmd = ([str(SEVEN_ZIP), "a", "-t7z", "-mx=0", "-sdel"]
           + split_flag
           + [zip_name, str(CONVERSION_DIR / "*")])

    log(f"  Creating archive: {zip_name}")
    subprocess.run(cmd, cwd=str(BASE_DIR))

    # Move single or multi-part archive into output folder
    parts = sorted(BASE_DIR.glob("*.001"))
    if parts:
        n = 1
        while True:
            part_list = list(BASE_DIR.glob(f"*.{n:03d}"))
            if not part_list:
                break
            for pf in part_list:
                shutil.move(str(pf), str(out_folder / pf.name))
            n += 1
        log(f"  Multi-part archive moved to: {out_folder}")
    else:
        zf = BASE_DIR / zip_name
        if zf.exists():
            shutil.move(str(zf), str(out_folder / zf.name))
        log(f"  Archive moved to: {out_folder}")

    if appid:
        (out_folder / appid).touch()

    # Drop crashfix.bat into the repack, loose next to the appid file (not zipped)
    crashfix_src = SETUP_DIR / "crashfix.bat"
    if crashfix_src.exists():
        shutil.copy2(str(crashfix_src), str(out_folder / crashfix_src.name))
        log(f"  Added crashfix.bat to: {out_folder}")
    else:
        log(f"  [WARN] crashfix.bat not found in Setup — skipped: {crashfix_src}")

    # VR Optional: restore backed-up files for the 2nd pass
    if optional.exists():
        dll_save = SAVE_DIR / "AGRepackInstaller.dll"
        bin_save = SAVE_DIR / "Data.bin"
        if dll_save.exists():
            shutil.move(str(dll_save), str(CONVERSION_DIR / "AGRepackInstaller.dll"))
        if bin_save.exists():
            shutil.move(str(bin_save), str(CONVERSION_DIR / "Data.bin"))
        optional.unlink()
        log("  VR Optional files restored for second pass.")

    return True


# ── Archive art ──────────────────────────────────────────────────────────────

def work_archive_art(log) -> bool:
    if not SETTINGS_INI.exists():
        log("[ERROR] settings.ini not found.")
        return False
    if not SEVEN_ZIP.exists():
        log(f"[ERROR] 7z.exe not found: {SEVEN_ZIP}")
        return False

    lines    = ini_read(SETTINGS_INI)
    raw_name = ini_get(lines, "Name", "game")
    clean    = re.sub(r"[^\w\-\s]", "", raw_name).strip()
    arc_name = re.sub(r"[\s\W]", "", clean).lower()

    bg_dir  = SETUP_DIR / "Background"
    old_art = bg_dir / "_OldGameArt"
    bg_dir.mkdir(exist_ok=True)
    old_art.mkdir(exist_ok=True)

    art_files = [
        "Welcome.bmp", "Finish.bmp", "icon.ico", "splash.png",
        "logo.png", "banner.bmp", "library_hero.jpg",
        "logo_2x.png", "library_hero_2x.jpg", "AGRepackInstaller.dll",
    ]
    for fname in art_files:
        moved = False
        for search_dir in (SETUP_DIR, BASE_DIR):
            src = search_dir / fname
            if not src.exists():
                continue
            if not moved:
                shutil.move(str(src), str(bg_dir / fname))
                moved = True
            else:
                src.unlink()   # duplicate — drop it so nothing's left behind

    # Collect settings.ini from either location, drop any duplicates
    moved_ini = False
    for ini_src in (SETTINGS_INI, SETUP_DIR / "settings.ini"):
        if not ini_src.exists():
            continue
        if not moved_ini:
            shutil.move(str(ini_src), str(bg_dir / "settings.ini"))
            moved_ini = True
        else:
            ini_src.unlink()

    zip_path = BASE_DIR / f"{arc_name}.7z"
    cmd = [str(SEVEN_ZIP), "a", "-t7z", "-mx=9", "-sdel",
           str(zip_path), str(bg_dir / "*"),
           "-xr!*\\*", "-xr!_OldGameArt", "-xr!_OldGameArt\\*"]
    log(f"  Archiving game art as: {arc_name}.7z")
    subprocess.run(cmd, cwd=str(BASE_DIR))

    # Belt-and-suspenders cleanup of the log no matter where it landed
    for stray in (bg_dir / "repack_log.txt",
                  SETUP_DIR / "repack_log.txt",
                  BASE_DIR  / "repack_log.txt"):
        if stray.exists():
            try:
                stray.unlink()
            except OSError:
                pass

    if zip_path.exists():
        shutil.move(str(zip_path), str(old_art / zip_path.name))
        log(f"  Art archive saved: {old_art / zip_path.name}")

    return True


# ── Recompile Fix ─────────────────────────────────────────────────────────────

def work_recompile_fix(log, pre_archive_hook=None) -> bool:
    """
    Recompile Fix workflow (mirrors RecompileFix.ps1).
    Expects in Setup/: data.bin, settings.ini, AGRepackInstaller.dll
    Moves them into place, compiles, merges, zips, archives art.
    pre_archive_hook: optional callable() run just before work_archive_art.
    """
    setup_data   = SETUP_DIR / "data.bin"
    setup_ini    = SETUP_DIR / "settings.ini"
    setup_dll    = SETUP_DIR / "AGRepackInstaller.dll"

    missing = [p.name for p in (setup_data, setup_ini, setup_dll) if not p.exists()]
    if missing:
        log(f"[ERROR] Missing from Setup/ folder: {', '.join(missing)}")
        log("        Place data.bin, settings.ini, and AGRepackInstaller.dll in the Setup folder first.")
        return False

    log("  Moving files from Setup/ into place...")
    CONVERSION_DIR.mkdir(parents=True, exist_ok=True)
    shutil.move(str(setup_data), str(CONVERSION_DIR / "data.bin"))
    shutil.move(str(setup_ini),  str(SETTINGS_INI))
    shutil.move(str(setup_dll),  str(CONVERSION_DIR / "AGRepackInstaller.dll"))
    log("  Files moved.")

    work_copy_finish_bmp(log)

    log("  Compiling Inno Setup script...")
    ok = work_compile_blocking(log)
    if not ok:
        log("[ERROR] Compile failed — stopping recompile fix.")
        return False

    exe_src  = SETUP_FILES / "AGRepackInstaller.exe"
    exe_dest = CONVERSION_DIR / "AGRepackInstaller.exe"
    if exe_src.exists():
        shutil.move(str(exe_src), str(exe_dest))
        log(f"  AGRepackInstaller.exe  →  {exe_dest}")
    else:
        log("[WARN] AGRepackInstaller.exe not found after compile.")

    log("  Merging DLL into EXE...")
    work_internal_dll(log, blocking_compile=True)

    log("  Zipping final package...")
    work_zip_and_name(log)

    log("  Archiving game art...")
    if pre_archive_hook:
        pre_archive_hook()
    work_archive_art(log)
    return True


# ═══════════════════════════════════════════════════════════════════════════
#  Steam art downloader
# ═══════════════════════════════════════════════════════════════════════════
#
#  Given a Game Directory + Steam App ID we can pull every bit of store art we
#  need for a repack straight from Steam:
#     •  icon.ico          →  parent folder of the game directory
#     •  library hero + logo (2x if available, else standard)  →  Setup\ folder
#     •  every store screenshot, numbered 1.jpg, 2.jpg, ...     →  parent folder
#
#  Only the standard library (urllib) is used so the PyInstaller --onefile build
#  needs no extra dependencies.

import json
import struct
import urllib.request
from typing import Optional, Tuple

# Steam serves the same assets from several mirrors — try them in order so a
# single flaky host doesn't sink the whole download.
STEAM_CDN_HOSTS = (
    "https://steamcdn-a.akamaihd.net/steam/apps/{appid}/{fname}",
    "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/{appid}/{fname}",
    "https://cdn.cloudflare.steamstatic.com/steam/apps/{appid}/{fname}",
)
_STEAM_UA = {"User-Agent": "Mozilla/5.0"}

# Newer apps no longer keep art at the flat .../apps/{appid}/logo.png path — the
# real files live under a per-asset content-hash folder and can carry a language
# suffix (logo_schinese.png).  Those exact relative paths live in the app's own
# common.library_assets_full block (the same data SteamDB shows).  We read that
# (keyless) and build the true CDN URL from it as a fallback.
STEAM_ASSET_BASE  = "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/{appid}/{path}"
STEAM_APPINFO_URL = "https://api.steamcmd.net/v1/info/{appid}"
_appinfo_cache = {}


def _http_get(url: str, timeout: int = 30) -> Optional[bytes]:
    """GET a URL and return its body, or None on any failure / non-200."""
    try:
        req = urllib.request.Request(url, headers=_STEAM_UA)
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            if resp.status != 200:
                return None
            return resp.read()
    except Exception:
        return None


def _parse_version(v: str) -> tuple:
    """Turn 'v1.2.3' / '1.2.3-beta' into a comparable tuple of ints (1, 2, 3)."""
    return tuple(int(n) for n in re.findall(r"\d+", v or ""))


def check_for_update(current: str = __version__):
    """Return (latest_tag, release_url, exe_asset_url) when a newer GitHub
    release exists, else None.  exe_asset_url is the direct download for the
    first .exe attached to the release (None if the release has no exe asset).
    Never raises — no network, no releases, or a parse error all just return
    None so the app carries on silently."""
    raw = _http_get(
        f"https://api.github.com/repos/{GITHUB_REPO}/releases/latest", timeout=10)
    if not raw:
        return None
    try:
        rel = json.loads(raw)
    except ValueError:
        return None
    tag = (rel.get("tag_name") or "").strip()
    url = rel.get("html_url") or f"https://github.com/{GITHUB_REPO}/releases"
    if not (tag and _parse_version(tag) > _parse_version(current)):
        return None
    # onedir builds ship as a .zip (exe + _internal); prefer that, fall back to
    # a bare .exe if a release only attaches one.
    payload = None
    for want in (".zip", ".exe"):
        for asset in (rel.get("assets") or []):
            name = (asset.get("name") or "").lower()
            if name.endswith(want) and asset.get("browser_download_url"):
                payload = asset["browser_download_url"]
                break
        if payload:
            break
    return tag, url, payload


def _download_stream(url: str, dest: Path, chunk: int = 65536) -> None:
    """Stream a URL to `dest` (follows redirects, e.g. GitHub asset → storage).
    Raises on failure so the caller can report it and abort the swap."""
    req = urllib.request.Request(url, headers=_STEAM_UA)
    with urllib.request.urlopen(req, timeout=120) as resp, open(dest, "wb") as fh:
        while True:
            block = resp.read(chunk)
            if not block:
                break
            fh.write(block)


# Names used by the self-updater, created next to the exe (BASE_DIR).
UPDATE_STAGING = "_update_tmp"
UPDATER_BAT    = "_update.bat"
UPDATE_ZIP     = "_update.zip"


def cleanup_update_leftovers() -> None:
    """Remove the staging dir / updater script / zip left by a previous
    self-update.  Best-effort — a leftover is harmless and cleared next launch."""
    if not getattr(sys, "frozen", False):
        return
    base = Path(sys.executable).parent
    for leftover in (base / UPDATE_STAGING, base / UPDATER_BAT, base / UPDATE_ZIP):
        try:
            if leftover.is_dir():
                shutil.rmtree(leftover, ignore_errors=True)
            elif leftover.exists():
                leftover.unlink()
        except OSError:
            pass


def pending_update_staging() -> Optional[Path]:
    """If a previous self-update downloaded a build but never swapped it in
    (e.g. the files were still locked when the updater ran), return the
    staging dir that still holds the new exe so the swap can be retried.
    Returns None when there's nothing to resume.  Frozen build only."""
    if not getattr(sys, "frozen", False):
        return None
    base    = Path(sys.executable).parent
    staging = base / UPDATE_STAGING
    if not staging.is_dir():
        return None
    exe_name = Path(sys.executable).name
    if (staging / exe_name).is_file():
        return staging
    # The zip may wrap everything in a single top-level folder.
    subdirs = [e for e in staging.iterdir() if e.is_dir()]
    if len(subdirs) == 1 and (subdirs[0] / exe_name).is_file():
        return subdirs[0]
    return None


def _steam_cdn_get(appid: str, fname: str) -> Optional[bytes]:
    """Fetch a per-app CDN asset (library_hero.jpg, logo.png, ...) trying each
    mirror in turn.  Returns the bytes or None if every host failed / 404'd."""
    for host in STEAM_CDN_HOSTS:
        data = _http_get(host.format(appid=appid, fname=fname))
        if data:
            return data
    return None


def _steam_appinfo(appid: str) -> dict:
    """Fetch & cache the app's 'common' appinfo block (keyless, stdlib only).
    Returns {} on any failure so callers can treat it as 'no data'."""
    if appid not in _appinfo_cache:
        common = {}
        raw = _http_get(STEAM_APPINFO_URL.format(appid=appid), timeout=20)
        if raw:
            try:
                common = (json.loads(raw).get("data", {})
                          .get(appid, {}).get("common", {})) or {}
            except (ValueError, AttributeError):
                common = {}
        _appinfo_cache[appid] = common
    return _appinfo_cache[appid]


def _kind_from_candidates(candidates) -> Optional[str]:
    """Map our output filenames to the library_assets_full block that feeds them."""
    joined = " ".join(candidates).lower()
    if "logo" in joined:
        return "library_logo"
    if "hero" in joined:
        return "library_hero"
    if "capsule" in joined or "600x900" in joined:
        return "library_capsule"
    return None


def _steam_pick_asset(appid: str, candidates) -> Tuple[Optional[str], Optional[bytes]]:
    """Try each filename in `candidates` (highest quality first) on the flat CDN
    path.  If none exist — newer apps store art under a content-hash folder with
    a language suffix — resolve the real relative path from the app's
    library_assets_full metadata, preferring English then any available
    language.  The output filename stays canonical (logo.png / logo_2x.png /
    library_hero.jpg / ...) so the installer is unchanged.
    Returns (filename, bytes), or (None, None) if nothing could be fetched."""
    # 1) Legacy flat path — fast, still correct for older apps.
    for fname in candidates:
        data = _steam_cdn_get(appid, fname)
        if data:
            return fname, data

    # 2) Fallback: use the app's own asset metadata (what SteamDB shows).
    kind = _kind_from_candidates(candidates)
    if kind:
        hi_name, lo_name = candidates[0], candidates[-1]   # 2x preferred, then 1x
        block = _steam_appinfo(appid).get("library_assets_full", {}).get(kind, {})
        for res_key, out_name in (("image2x", hi_name), ("image", lo_name)):
            langs = block.get(res_key, {})
            if not isinstance(langs, dict):
                continue
            for lang in ["english"] + [l for l in langs if l != "english"]:
                rel = langs.get(lang)
                if not rel:
                    continue
                data = _http_get(STEAM_ASSET_BASE.format(appid=appid, path=rel))
                if data:
                    return out_name, data
    return None, None


# ── Icon: existing .ico, or extracted from the game exe ──────────────────────

_RT_ICON, _RT_GROUP_ICON = 3, 14
# Executables that are never the game itself — skip them when auto-picking one.
_EXE_JUNK = re.compile(
    r"(unins|vc_?redist|vcredist|dxsetup|directx|dotnet|oalinst|_setup|"
    r"crashhandler|crashpad|handler|dxwebsetup|redist|installer)",
    re.IGNORECASE)


def extract_ico_from_exe(exe_path) -> Optional[bytes]:
    """Rebuild the primary .ico from a Windows PE executable's icon resources.

    Reads the RT_GROUP_ICON / RT_ICON resource tree and stitches the images
    back into a real multi-resolution .ico.  Pure standard library — no ffmpeg,
    no image tools (ffmpeg cannot read PE icon resources at all).
    Returns the .ico bytes, or None if the exe has no icon / isn't a PE file."""
    try:
        data = Path(exe_path).read_bytes()
    except OSError:
        return None
    if data[:2] != b"MZ":
        return None
    try:
        e_lfanew = struct.unpack_from("<I", data, 0x3C)[0]
        if data[e_lfanew:e_lfanew + 4] != b"PE\0\0":
            return None
        coff = e_lfanew + 4
        num_sections, = struct.unpack_from("<H", data, coff + 2)
        opt_size, = struct.unpack_from("<H", data, coff + 16)
        opt = coff + 20
        magic, = struct.unpack_from("<H", data, opt)
        dd = opt + (0x60 if magic == 0x10B else 0x70)      # PE32 vs PE32+
        rsrc_rva, _ = struct.unpack_from("<II", data, dd + 2 * 8)  # dir entry [2]
        if not rsrc_rva:
            return None

        sec = opt + opt_size
        sections = []
        for i in range(num_sections):
            vsize, vaddr, rawsize, rawptr = struct.unpack_from(
                "<IIII", data, sec + i * 40 + 8)
            sections.append((vaddr, vsize, rawptr, rawsize))

        def rva_to_off(rva):
            for vaddr, vsize, rawptr, rawsize in sections:
                if vaddr <= rva < vaddr + max(vsize, rawsize):
                    return rawptr + (rva - vaddr)
            return None

        res_base = rva_to_off(rsrc_rva)
        if res_base is None:
            return None

        def parse_dir(off):
            n_named, n_id = struct.unpack_from("<HH", data, off + 12)
            out = []
            for i in range(n_named + n_id):
                name, child = struct.unpack_from("<II", data, off + 16 + i * 8)
                out.append((name, bool(child & 0x80000000),
                            res_base + (child & 0x7FFFFFFF)))
            return out

        def find_type(type_id):
            for name, is_dir, child in parse_dir(res_base):
                if not (name & 0x80000000) and name == type_id and is_dir:
                    return child
            return None

        def first_leaf(dir_off):
            for name, is_dir, child in parse_dir(dir_off):
                if is_dir:
                    for _n, d2, c2 in parse_dir(child):
                        if not d2:
                            return struct.unpack_from("<II", data, c2)
                else:
                    return struct.unpack_from("<II", data, child)
            return None

        grp_dir = find_type(_RT_GROUP_ICON)
        icon_dir = find_type(_RT_ICON)
        if grp_dir is None or icon_dir is None:
            return None

        grp = first_leaf(grp_dir)
        if not grp:
            return None
        grp_off = rva_to_off(grp[0])
        grp_data = data[grp_off:grp_off + grp[1]]

        icon_map = {}
        for name, is_dir, child in parse_dir(icon_dir):
            rid = name & 0x7FFFFFFF
            leaf = None
            if is_dir:
                for _n, d2, c2 in parse_dir(child):
                    if not d2:
                        leaf = struct.unpack_from("<II", data, c2)
                        break
            icon_map[rid] = leaf

        _, _, count = struct.unpack_from("<HHH", grp_data, 0)
        head = struct.pack("<HHH", 0, 1, count)
        entries, images = b"", []
        offset = 6 + count * 16
        for i in range(count):
            b = 6 + i * 14
            w, h, colors, res, planes, bpp, _nb = struct.unpack_from(
                "<BBBBHHI", grp_data, b)
            rid, = struct.unpack_from("<H", grp_data, b + 12)
            leaf = icon_map.get(rid)
            if not leaf:
                continue
            img_off = rva_to_off(leaf[0])
            img = data[img_off:img_off + leaf[1]]
            entries += struct.pack("<BBBBHHII", w, h, colors, res,
                                   planes, bpp, len(img), offset)
            offset += len(img)
            images.append(img)
        if not images:
            return None
        return head + entries + b"".join(images)
    except (struct.error, IndexError):
        return None


def _pick_game_exe(game_dir: Path, exe_hint: str = "") -> Optional[Path]:
    """Resolve the game's main executable: the hint from the form if it points
    at a real file, otherwise the largest non-installer .exe in the game dir."""
    if exe_hint:
        cand = Path(exe_hint)
        if not cand.is_absolute():
            cand = game_dir / exe_hint
        if cand.is_file() and cand.suffix.lower() == ".exe":
            return cand
    exes = [p for p in game_dir.rglob("*.exe")
            if p.is_file() and not _EXE_JUNK.search(p.name)]
    if not exes:
        return None
    return max(exes, key=lambda p: p.stat().st_size)


def resolve_game_icon(game_dir: Path, exe_hint: str, log) -> Optional[bytes]:
    """Return .ico bytes for the game: an existing .ico if one ships with the
    game (an icon is already an icon — no conversion), otherwise the icon
    extracted from the game's main executable."""
    # 1 — an existing .ico shipped with the game
    icos = sorted(game_dir.rglob("*.ico"),
                  key=lambda p: (p.name.lower() != "icon.ico", -p.stat().st_size))
    if icos:
        log(f"  Using existing icon: {icos[0].name}")
        try:
            return icos[0].read_bytes()
        except OSError:
            pass
    # 2 — fall back to the game executable's embedded icon
    exe = _pick_game_exe(game_dir, exe_hint)
    if exe:
        ico = extract_ico_from_exe(exe)
        if ico:
            log(f"  Extracted icon from executable: {exe.name}")
            return ico
        log(f"  [WARN] {exe.name} has no embedded icon to extract.")
    else:
        log("  [WARN] No suitable game .exe found for icon extraction.")
    return None


def _read_steam_buildid(game_dir: Path, appid: str) -> Optional[str]:
    """If the game lives inside a Steam library, read its build id from
    steamapps/appmanifest_<appid>.acf.  Returns the build id string or None."""
    for parent in [game_dir] + list(game_dir.parents):
        if parent.name.lower() == "steamapps":
            acf = parent / f"appmanifest_{appid}.acf"
            if acf.is_file():
                try:
                    text = acf.read_text(encoding="utf-8", errors="replace")
                except OSError:
                    return None
                m = re.search(r'"buildid"\s*"(\d+)"', text)
                if m:
                    return m.group(1)
            break
    return None


def find_steam_appid(game_dir: Path) -> Optional[str]:
    """Search a game folder (and every subfolder) for a steam_appid.txt and
    return the App ID it contains, or None if there isn't one.

    Steam drops this file next to the game executable, so it's the most
    reliable way to identify a game straight from a copied folder."""
    try:
        for cand in game_dir.rglob("*"):
            try:
                if cand.is_file() and cand.name.lower() == "steam_appid.txt":
                    txt = cand.read_text(encoding="utf-8", errors="replace")
                    m = re.search(r"\d+", txt)
                    if m:
                        return m.group(0)
            except OSError:
                continue
    except OSError:
        pass
    return None


def steam_get_latest_buildid(appid: str, log) -> Optional[str]:
    """Fetch the current public-branch build id for an app from the public
    steamcmd.net mirror, or None if it can't be reached / parsed.

    This is the *newest* build on Steam — the caller should treat it as a
    best guess, since the folder being repacked may be an older build."""
    url = f"https://api.steamcmd.net/v1/info/{appid}"
    raw = _http_get(url)
    if not raw:
        return None
    try:
        data = json.loads(raw.decode("utf-8", "replace"))
    except Exception:
        return None
    try:
        app = data["data"][str(appid)]
        bid = app["depots"]["branches"]["public"]["buildid"]
    except (KeyError, TypeError, AttributeError):
        return None
    bid = str(bid).strip()
    return bid or None


def steam_get_appdetails(appid: str, log) -> dict:
    """Return the Steam store 'data' object for an app (name, screenshots,
    developers, ...), or {} if it can't be fetched."""
    url = f"https://store.steampowered.com/api/appdetails?appids={appid}"
    raw = _http_get(url)
    if not raw:
        log("  [WARN] Could not reach the Steam store API.")
        return {}
    try:
        data = json.loads(raw.decode("utf-8", "replace"))
    except Exception:
        log("  [WARN] Steam store API returned unreadable data.")
        return {}
    entry = data.get(str(appid)) if isinstance(data, dict) else None
    if not entry or not entry.get("success"):
        log(f"  [WARN] No store data found for App ID {appid}.")
        return {}
    return entry.get("data", {}) or {}


def work_download_steam_art(appid: str, game_dir: str, exe_hint: str,
                            log, apply_meta=None) -> bool:
    """Download art + set up icon for a repack.

    icon.ico  → the game folder AND the Setup\\ folder
                (existing game icon if present, otherwise extracted from the
                 game .exe — no PNG conversion)
    hero+logo → Setup\\ folder  (2x variant when it exists, standard otherwise)
    screenshots → Setup\\Background, numbered 1.jpg, 2.jpg, ...

    apply_meta(name, buildid): optional callback used to auto-fill empty
    Game Name / Build fields on the GUI thread.
    """
    appid = str(appid).strip()
    if not appid.isdigit():
        log("[ERROR] App ID must be numeric.")
        return False

    game_path = Path(game_dir)
    if not game_path.exists():
        log(f"[ERROR] Game directory not found: {game_dir}")
        return False

    SETUP_DIR.mkdir(parents=True, exist_ok=True)

    log(f"  Fetching Steam art for App ID {appid} ...")
    got_any = False

    details = steam_get_appdetails(appid, log)

    # ── Store metadata → auto-fill empty Name / Build fields ─────────────────
    if apply_meta:
        name = (details.get("name") or "").strip()
        buildid = _read_steam_buildid(game_path, appid)
        if name or buildid:
            apply_meta(name, buildid)

    # ── icon.ico  (existing icon, else extracted from the exe) ───────────────
    ico_bytes = resolve_game_icon(game_path, exe_hint, log)
    if ico_bytes:
        for dest in (game_path / "icon.ico", SETUP_DIR / "icon.ico"):
            try:
                dest.write_bytes(ico_bytes)
                log(f"  icon.ico saved to {dest}")
            except OSError as exc:
                log(f"  [WARN] Could not write {dest}: {exc}")
        got_any = True
    else:
        log("  [WARN] No icon could be found or extracted for this game.")

    # ── Logo (2x if available, else standard) ────────────────────────────────
    logo_name, logo_bytes = _steam_pick_asset(appid, ("logo_2x.png", "logo.png"))
    if logo_bytes:
        (SETUP_DIR / logo_name).write_bytes(logo_bytes)
        log(f"  Logo saved to Setup\\{logo_name}")
        got_any = True
    else:
        log("  [WARN] No logo art available on Steam for this App ID.")

    # ── Library hero (2x if available, else standard) ────────────────────────
    hero_name, hero_bytes = _steam_pick_asset(
        appid, ("library_hero_2x.jpg", "library_hero.jpg"))
    if hero_bytes:
        (SETUP_DIR / hero_name).write_bytes(hero_bytes)
        log(f"  Library hero saved to Setup\\{hero_name}")
        got_any = True
    else:
        log("  [WARN] No library hero art available on Steam for this App ID.")

    # ── Screenshots (numbered 1.jpg, 2.jpg, ...) ─────────────────────────────
    shots = [s.get("path_full") for s in (details.get("screenshots") or [])
             if s.get("path_full")]
    if shots:
        shots_dir = SETUP_DIR / "Background"
        shots_dir.mkdir(parents=True, exist_ok=True)
        log(f"  Found {len(shots)} screenshots — downloading to {shots_dir} ...")
        saved = 0
        for idx, img_url in enumerate(shots, start=1):
            data = _http_get(img_url)
            if not data:
                log(f"    [WARN] Failed to download screenshot {idx}.")
                continue
            (shots_dir / f"{idx}.jpg").write_bytes(data)
            saved += 1
        log(f"  Saved {saved}/{len(shots)} screenshots.")
        got_any = got_any or saved > 0
    else:
        log("  [WARN] No store screenshots found for this App ID.")

    if got_any:
        log("  Steam art download complete.")
    else:
        log("[ERROR] Nothing could be downloaded — check the App ID and connection.")
    return got_any


# ═══════════════════════════════════════════════════════════════════════════
#  GUI
# ═══════════════════════════════════════════════════════════════════════════

class RepackApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title(f"AG Repack GUI  v{__version__}  –  by DMP")
        if APP_ICON.exists():
            try:
                self.root.iconbitmap(default=str(APP_ICON))
            except tk.TclError:
                pass
        self.root.configure(bg=BG)
        self.root.minsize(860, 700)
        self._busy = False

        self._init_vars()
        self._apply_styles()
        self._build_ui()
        self.repacker_var.set(get_repacker())
        # Run startup check after the window is fully drawn
        self.root.after(150, self._check_existing_settings)
        # If a previous self-update downloaded a build but never swapped it in,
        # offer to finish it now; otherwise clear any stray leftovers and look
        # for a newer release — all without blocking the UI.
        if pending_update_staging() is not None:
            self.root.after(400, self._resume_pending_update)
        else:
            threading.Thread(target=cleanup_update_leftovers, daemon=True).start()
            self.root.after(1200, self._start_update_check)

    # ── tk.Variables ─────────────────────────────────────────────────────────

    def _init_vars(self):
        S = tk.StringVar
        B = tk.BooleanVar
        self.repacker_var   = S()
        self.game_dir_var   = S()
        self.game_type_var  = S(value="PC")
        self.name_var       = S()
        self.appid_var      = S()
        self.build_var      = S()
        self.size_var       = S()
        self.compact_var    = B()
        self.admin_var      = B()
        self.infobefore_var = B()
        self.enablebat_var  = B()
        self.batfile_var    = S()
        self.exe1_var       = S()
        self.exe1p_var      = S()
        self.exe2_var       = S()
        self.exe2p_var      = S()
        self.exe3_var       = S()
        self.exe3p_var      = S()
        self.exe4_var       = S()
        self.exe4p_var      = S()
        self.meta_var       = B()
        self.do_rename_var  = B()
        self.do_dlc_var     = B()
        self.preset_var     = S(value="12")

        # ── VD.bat auto-fill state ───────────────────────────────────
        #   The VD.bat launcher lives next to the SteamVR exe, so its path is
        #   derived automatically (…\Win64\Game.exe → …\Win64\VD.bat) while the
        #   user hasn't hand-edited it.  _vd_last_auto remembers the last value
        #   we filled in; once the field diverges from it the user has taken
        #   over and we stop syncing.  _loading_cfg suppresses the trace while a
        #   settings.ini is being loaded.
        self._vd_last_auto = ""
        self._loading_cfg  = False
        self.exe1_var.trace_add("write", self._autofill_vd_vr)
        self.exe2_var.trace_add("write", self._autofill_vd_vropt)

    # ── ttk style ─────────────────────────────────────────────────────────────

    def _apply_styles(self):
        s = ttk.Style()
        s.theme_use("clam")
        s.configure("TNotebook",      background=BG,    borderwidth=0, tabmargins=0)
        s.configure("TNotebook.Tab",  background=PANEL, foreground=FG2,
                    padding=[16, 7],  font=("Segoe UI", 10))
        s.map("TNotebook.Tab",
              background=[("selected", ACCENT)],
              foreground=[("selected", "#ffffff")])
        s.configure("TFrame",        background=BG)
        s.configure("TScrollbar",    background=PANEL,  troughcolor=BG,
                    arrowcolor=FG2,  borderwidth=0)
        s.configure("Vertical.TScrollbar", width=8)

    # ── Top-level layout ──────────────────────────────────────────────────────

    def _build_ui(self):
        # ── Header bar
        hdr = tk.Frame(self.root, bg="#0a0f1e", pady=10)
        hdr.pack(fill="x")
        tk.Label(hdr, text="AG Repack GUI", bg="#0a0f1e", fg=ACCENT,
                 font=("Segoe UI", 16, "bold")).pack(side="left", padx=16)
        tk.Label(hdr, text=f"v{__version__}", bg="#0a0f1e", fg=FG2,
                 font=("Segoe UI", 9)).pack(side="left", padx=(0, 8))
        tk.Label(hdr, text="Made by DMP of ARMGDDN Games",
                 bg="#0a0f1e", fg=FG2, font=("Segoe UI", 10)).pack(side="left")
        tk.Button(hdr, text="?", command=self._show_about,
                  bg="#0a0f1e", fg=ACCENT, activebackground="#0a0f1e",
                  activeforeground=FG2, bd=0, relief="flat", cursor="hand2",
                  font=("Segoe UI", 14, "bold"), padx=10).pack(side="right", padx=16)
        # Hidden until the background check finds a newer release.
        self.update_lbl = tk.Label(
            hdr, text="", bg="#0a0f1e", fg=WARN, cursor="hand2",
            font=("Segoe UI", 10, "bold"))

        # ── Notebook
        nb = ttk.Notebook(self.root)
        nb.pack(fill="both", expand=True, padx=10, pady=(8, 0))
        self._build_tab_settings(nb)
        self._build_tab_build(nb)

        # ── Log area
        log_outer = tk.Frame(self.root, bg=BG)
        log_outer.pack(fill="both", expand=False, padx=10, pady=(4, 8))
        tk.Label(log_outer, text="Output Log", bg=BG, fg=FG2,
                 font=("Segoe UI", 9, "bold")).pack(anchor="w", padx=2)
        self.log_box = scrolledtext.ScrolledText(
            log_outer, height=9, bg="#0a0f1e", fg=FG,
            font=("Cascadia Code", 9), insertbackground=FG,
            relief="flat", bd=0, selectbackground=ACCENT)
        self.log_box.pack(fill="both", expand=True)
        self.log_box.config(state="disabled")

    # ══════════════════════════════════════════════════════════════════════════
    #  Startup: detect existing settings.ini
    # ══════════════════════════════════════════════════════════════════════════

    # ── Update check ──────────────────────────────────────────────────────────

    def _start_update_check(self):
        threading.Thread(target=self._update_check_worker, daemon=True).start()

    def _update_check_worker(self):
        try:
            result = check_for_update()
        except Exception:
            result = None
        if result:
            tag, url, asset = result
            self.root.after(0, lambda: self._on_update_available(tag, url, asset))

    def _on_update_available(self, tag, url, asset_url):
        # Persistent clickable banner in the header ...
        self.update_lbl.config(text=f"⬆  Update available: {tag}  —  click to install")
        self.update_lbl.bind(
            "<Button-1>", lambda _e: self._prompt_update(tag, url, asset_url))
        self.update_lbl.pack(side="right", padx=12)
        try:
            self.log(f"[UPDATE] New version {tag} available — {url}")
        except Exception:
            pass
        # ... and prompt once now.
        self._prompt_update(tag, url, asset_url)

    def _prompt_update(self, tag, url, asset_url):
        frozen = getattr(sys, "frozen", False)
        if frozen and asset_url:
            if messagebox.askyesno(
                    "Update available",
                    f"A new version ({tag}) is available — you have v{__version__}.\n\n"
                    "Download and install it now?\n"
                    "The app will close and reopen automatically.",
                    icon="info"):
                self._run_self_update(asset_url, tag)
        else:
            # Dev run (.py) or a release with no exe asset — open the page.
            if messagebox.askyesno(
                    "Update available",
                    f"A new version ({tag}) is available — you have v{__version__}.\n\n"
                    "Open the download page?",
                    icon="info"):
                webbrowser.open(url)

    def _run_self_update(self, asset_url, tag):
        """Download the new build (a .zip of exe + _internal), extract it, then
        hand off to a small batch script that runs after this process exits:
        it waits, copies the new files over the app folder (leaving the repack
        toolkit and settings untouched), relaunches the exe, and deletes itself.
        A running app can't overwrite its own locked DLLs, so the swap must
        happen from outside the process."""
        win = tk.Toplevel(self.root)
        win.title("Updating")
        win.configure(bg="#0a0f1e")
        win.resizable(False, False)
        win.grab_set()
        win.update_idletasks()
        pw, ph = self.root.winfo_width(), self.root.winfo_height()
        px, py = self.root.winfo_rootx(), self.root.winfo_rooty()
        w, h = 360, 120
        win.geometry(f"{w}x{h}+{px + (pw - w)//2}+{py + (ph - h)//2}")
        tk.Label(win, text=f"Downloading {tag} ...", bg="#0a0f1e", fg=FG,
                 font=("Segoe UI", 10)).pack(pady=(24, 12))
        bar = ttk.Progressbar(win, mode="indeterminate", length=300)
        bar.pack()
        bar.start(12)

        def worker():
            base = Path(sys.executable).parent
            staging = base / UPDATE_STAGING
            zip_path = base / UPDATE_ZIP
            try:
                shutil.rmtree(staging, ignore_errors=True)
                _download_stream(asset_url, zip_path)
                staging.mkdir(parents=True, exist_ok=True)
                with zipfile.ZipFile(zip_path) as zf:
                    zf.extractall(staging)
                try:
                    zip_path.unlink()
                except OSError:
                    pass
                # If the zip wrapped everything in a single top-level folder,
                # descend into it so we copy the exe + _internal, not the wrapper.
                entries = list(staging.iterdir())
                if len(entries) == 1 and entries[0].is_dir():
                    staging = entries[0]
            except Exception as exc:
                try:
                    zip_path.unlink()
                except OSError:
                    pass
                shutil.rmtree(base / UPDATE_STAGING, ignore_errors=True)
                self.root.after(0, lambda: self._update_failed(win, exc))
                return
            self.root.after(0, lambda: self._finalize_update(win, base, staging))

        threading.Thread(target=worker, daemon=True).start()

    def _update_failed(self, win, exc):
        try:
            win.destroy()
        except tk.TclError:
            pass
        messagebox.showerror("Update failed", f"Could not download the update:\n{exc}")

    def _finalize_update(self, win, base, staging):
        if self._spawn_updater(base, staging):
            self.root.destroy()
            sys.exit(0)
        # Spawn failed — _spawn_updater already showed the error; keep running.
        try:
            win.destroy()
        except tk.TclError:
            pass

    def _spawn_updater(self, base, staging) -> bool:
        """Write the updater batch and launch it detached so it survives this
        process exiting.  Returns True on launch, False (with an error box)
        if the updater couldn't be started."""
        exe_name = Path(sys.executable).name
        bat = base / UPDATER_BAT
        # %~1 app dir, %~2 staging dir, %~3 exe name, %~4 staging root.
        # The running app locks its own exe + runtime DLLs while it's alive, so
        # the swap must happen from this external script after the app exits.
        # robocopy's own /R retries wait out that lock (it keeps retrying the
        # locked exe until the old process releases it), so no clever wait
        # probe is needed. We then CHECK robocopy's exit code (0-7 = success,
        # >=8 = failure) instead of assuming it worked — the old updater's bug
        # was blindly deleting the staging folder and relaunching the OLD exe
        # even when the copy had failed. On failure we keep the staging folder,
        # write _update.log, and PAUSE the window so the error is visible.
        bat.write_text(
            "@echo off\r\n"
            'title AG Repack GUI - Updater\r\n'
            'set "APPDIR=%~1"\r\n'
            'set "COPYFROM=%~2"\r\n'
            'set "EXENAME=%~3"\r\n'
            'set "STAGEROOT=%~4"\r\n'
            'set "LOG=%APPDIR%\\_update.log"\r\n'
            'echo [update] start %date% %time%> "%LOG%"\r\n'
            "echo.\r\n"
            "echo   Updating AG Repack GUI - please wait...\r\n"
            "echo.\r\n"
            "rem /R:30 /W:1 keeps retrying the locked exe until the old app\r\n"
            "rem exits (~a few seconds); no /PURGE so user files are kept.\r\n"
            'robocopy "%COPYFROM%" "%APPDIR%" /E /R:30 /W:1 /NFL /NDL /NJH /NJS >> "%LOG%"\r\n'
            "set RC=%ERRORLEVEL%\r\n"
            'echo [update] robocopy exit %RC%>> "%LOG%"\r\n'
            "if %RC% geq 8 goto fail\r\n"
            'echo [update] success>> "%LOG%"\r\n'
            'rmdir /s /q "%STAGEROOT%" 2>nul\r\n'
            'start "" "%APPDIR%\\%EXENAME%"\r\n'
            'del /q "%~f0"\r\n'
            "exit\r\n"
            ":fail\r\n"
            'echo [update] FAILED (robocopy %RC%); kept in "%STAGEROOT%">> "%LOG%"\r\n'
            "echo.\r\n"
            "echo   *** UPDATE FAILED ^(robocopy code %RC%^) ***\r\n"
            "echo   The new files are still in: %STAGEROOT%\r\n"
            'echo   Details in: %LOG%\r\n'
            "echo.\r\n"
            'start "" "%APPDIR%\\%EXENAME%"\r\n'
            "pause\r\n"
            "exit\r\n",
            encoding="utf-8")
        # CREATE_NEW_CONSOLE gives the updater its own visible window (so a
        # failure is seen, not silent) that outlives this process exiting.
        new_console = 0x00000010 | 0x00000200
        try:
            subprocess.Popen(
                ["cmd", "/c", str(bat), str(base), str(staging), exe_name,
                 str(base / UPDATE_STAGING)],
                close_fds=True, creationflags=new_console)
        except OSError as exc:
            messagebox.showerror(
                "Update failed", f"Could not start the updater:\n{exc}")
            return False
        return True

    def _resume_pending_update(self):
        """A prior update downloaded a build but the swap didn't complete (the
        old exe/DLLs were still locked).  Offer to finish it now: the updater
        waits for this process to exit before copying, so relaunch-and-swap
        succeeds where the in-place attempt failed."""
        staging = pending_update_staging()
        if staging is None:
            return
        base = Path(sys.executable).parent
        if not messagebox.askyesno(
                "Finish update",
                "An update was downloaded earlier but not fully applied.\n\n"
                "Apply it now? The app will close, swap in the new files, "
                "and reopen."):
            # Declined — clear the leftovers so we don't ask again next launch.
            threading.Thread(target=cleanup_update_leftovers, daemon=True).start()
            self.root.after(1200, self._start_update_check)
            return
        if self._spawn_updater(base, staging):
            self.root.destroy()
            sys.exit(0)

    def _show_about(self):
        win = tk.Toplevel(self.root)
        win.title("About")
        win.configure(bg="#0a0f1e")
        win.resizable(False, False)
        if APP_ICON.exists():
            try:
                win.iconbitmap(str(APP_ICON))
            except tk.TclError:
                pass
        win.grab_set()

        # ── centre on parent ──────────────────────────────────────────────────
        win.update_idletasks()
        pw = self.root.winfo_width();  ph = self.root.winfo_height()
        px = self.root.winfo_rootx(); py = self.root.winfo_rooty()
        w, h = 420, 380
        win.geometry(f"{w}x{h}+{px + (pw - w)//2}+{py + (ph - h)//2}")

        pad = dict(bg="#0a0f1e")

        # ── heart / title ─────────────────────────────────────────────────────
        tk.Label(win, text="AG Repack GUI", font=("Segoe UI", 17, "bold"),
                 fg=ACCENT, **pad).pack(pady=(22, 0))
        tk.Label(win, text=f"version {__version__}", font=("Segoe UI", 9),
                 fg=FG2, **pad).pack(pady=(2, 0))
        tk.Label(win, text="Made with ♥ by DMP of ARMGDDN Games,",
                 font=("Segoe UI", 10), fg="#f472b6", **pad).pack()
        tk.Label(win, text="for ARMGDDN Games.",
                 font=("Segoe UI", 10), fg="#f472b6", **pad).pack(pady=(0, 18))

        sep = tk.Frame(win, bg=BORDER, height=1)
        sep.pack(fill="x", padx=24, pady=(0, 14))

        # ── link helper ───────────────────────────────────────────────────────
        def link(parent, label, url, color):
            lbl = tk.Label(parent, text=label, font=("Segoe UI", 10, "underline"),
                           fg=color, cursor="hand2", **pad)
            lbl.bind("<Button-1>", lambda _e: webbrowser.open(url))
            lbl.bind("<Enter>",    lambda _e: lbl.config(fg="white"))
            lbl.bind("<Leave>",    lambda _e: lbl.config(fg=color))
            return lbl

        def row(icon, caption, label, url, icon_color, link_color):
            f = tk.Frame(win, **pad)
            f.pack(fill="x", padx=32, pady=3)
            tk.Label(f, text=icon,    font=("Segoe UI", 11), fg=icon_color,  **pad).pack(side="left")
            tk.Label(f, text=caption, font=("Segoe UI", 9),  fg=FG2,         **pad).pack(side="left", padx=(6, 4))
            link(f, label, url, link_color).pack(side="left")

        row("✈",  "ARMGDDN Telegram",   "t.me/ARMGDDNGames",              "https://t.me/ARMGDDNGames",                   "#38bdf8", "#38bdf8")
        row("\U0001f4e6", "ARMGDDN Browser", "github.com/KaladinDMP/AGBrowser", "https://github.com/KaladinDMP/AGBrowser",     "#4ade80", "#4ade80")
        row("\U0001f310", "AG Beta Site",    "ARMGDDNBrowser.com",              "https://ARMGDDNBrowser.com",                  "#f59e0b", "#f59e0b")
        row("\U0001f431", "DMP's GitHub",    "github.com/KaladinDMP",           "https://github.com/KaladinDMP",               "#a78bfa", "#a78bfa")
        row("✉",  "Contact DMP",        "t.me/SickSoThr33",               "https://t.me/SickSoThr33",                    "#38bdf8", "#38bdf8")

        sep2 = tk.Frame(win, bg=BORDER, height=1)
        sep2.pack(fill="x", padx=24, pady=(14, 10))

        tk.Button(win, text="Close", command=win.destroy,
                  bg=BTN, fg=FG, activebackground=ACCENT, activeforeground=FG,
                  relief="flat", bd=0, padx=20, pady=5,
                  font=("Segoe UI", 9)).pack(pady=(0, 18))

    def _check_existing_settings(self):
        setup_ini = SETUP_DIR / "settings.ini"

        # Setup\ folder takes priority — it drives the Recompile Fix workflow.
        if setup_ini.exists():
            load = messagebox.askyesno(
                "settings.ini Found in Setup\\",
                "Found settings.ini in the Setup\\ folder.\n\n"
                "Copy it to the main folder and load its values into the form?",
                icon="question",
            )
            if load:
                shutil.copy2(str(setup_ini), str(SETTINGS_INI))
                self._load_settings_ini()

            do_fix = messagebox.askyesno(
                "Run Recompile Fix?",
                "Would you like to run the Recompile Fix workflow?\n\n"
                "Use this when you already have compressed data and just need\n"
                "to recompile / repackage (e.g. after a settings change).\n\n"
                "Before clicking YES, make sure the Setup\\ folder contains:\n"
                "  •  data.bin\n"
                "  •  settings.ini\n"
                "  •  AGRepackInstaller.dll\n"
                "  •  All game art files",
                icon="question",
            )
            if do_fix:
                data_conv  = CONVERSION_DIR / "data.bin"
                data_setup = SETUP_DIR / "data.bin"
                if not data_conv.exists() and not data_setup.exists():
                    proceed = messagebox.askokcancel(
                        "data.bin Not Found",
                        "data.bin is missing from the expected locations:\n\n"
                        f"  {data_conv}\n"
                        f"  — or —\n"
                        f"  {data_setup}\n\n"
                        "Fix that first, then click OK to continue.\n"
                        "Click Cancel if you need more time.",
                    )
                    if not proceed:
                        return
                self._run_recompile_fix()
            return

        # Fall back to root-dir settings.ini — just offer to populate the form.
        if SETTINGS_INI.exists():
            load = messagebox.askyesno(
                "settings.ini Found",
                "Found settings.ini in the repack folder.\n\n"
                "Load its values into the form?",
                icon="question",
            )
            if load:
                self._load_settings_ini()

    def _load_settings_ini(self):
        """Parse settings.ini and populate every form field."""
        lines = ini_read(SETTINGS_INI)
        if not lines:
            messagebox.showerror("Load Failed", "Could not read settings.ini.")
            return

        # ── Basic settings ───────────────────────────────────────────
        self.name_var.set(ini_get(lines, "Name"))
        self.appid_var.set(ini_get(lines, "APPID"))
        self.build_var.set(ini_get(lines, "Buildversion"))
        self.size_var.set(ini_get(lines, "Size"))
        rep = ini_get(lines, "REPACKER") or get_repacker()
        self.repacker_var.set(rep)
        self.compact_var.set(ini_get(lines, "CompactMode",    "0") == "1")
        self.admin_var.set(  ini_get(lines, "RunAppAsAdmin",  "0") == "1")

        # ── InfoBefore / Batch (section-aware) ───────────────────────
        self.infobefore_var.set(
            ini_get_in_section(lines, "InfoBefore", "Enable", "0") == "1")
        self.enablebat_var.set(
            ini_get_in_section(lines, "Batch", "Enable", "0") == "1")
        self.batfile_var.set(
            ini_get_in_section(lines, "Batch", "BatchFile", ""))

        # ── Executables ──────────────────────────────────────────────
        # Suppress VD.bat auto-fill while we push loaded values into the vars,
        # so an existing (possibly custom) VD.bat path is preserved as-is.
        self._loading_cfg  = True
        self._vd_last_auto = ""
        exes   = parse_exe_sections(lines)
        names  = [e.get("shortcutname", "").lower() for e in exes]
        has_flat = any("(flat)"    in n for n in names)
        has_vr   = any("(steamvr)" in n for n in names)

        def _exe(keyword):
            return next(
                (e for e in exes if keyword in e.get("shortcutname","").lower()),
                {}
            )

        if has_flat:
            gt = "VR Optional"
            flat    = _exe("(flat)")
            steamvr = _exe("(steamvr)")
            vd      = _exe("(vd)")
            meta    = _exe("(meta)")
            self.exe1_var.set(flat.get("exe",      ""));  self.exe1p_var.set(flat.get("exeparam",    ""))
            self.exe2_var.set(steamvr.get("exe",   ""));  self.exe2p_var.set(steamvr.get("exeparam", ""))
            self.exe3_var.set(vd.get("exe",        ""));  self.exe3p_var.set(vd.get("exeparam",      ""))
            if meta:
                self.meta_var.set(True)
                self.exe4_var.set(meta.get("exe",  ""));  self.exe4p_var.set(meta.get("exeparam",    ""))
        elif has_vr:
            gt = "VR"
            steamvr = _exe("(steamvr)") or (exes[0] if exes else {})
            vd      = _exe("(vd)")      or (exes[1] if len(exes) > 1 else {})
            meta    = _exe("(meta)")
            self.exe1_var.set(steamvr.get("exe",   ""));  self.exe1p_var.set(steamvr.get("exeparam", ""))
            self.exe2_var.set(vd.get("exe",        ""));  self.exe2p_var.set(vd.get("exeparam",      ""))
            if meta:
                self.meta_var.set(True)
                self.exe3_var.set(meta.get("exe",  ""));  self.exe3p_var.set(meta.get("exeparam",    ""))
        else:
            gt  = "PC"
            exe = exes[0] if exes else {}
            self.exe1_var.set(exe.get("exe",       ""));  self.exe1p_var.set(exe.get("exeparam",     ""))

        self._loading_cfg = False
        self.game_type_var.set(gt)
        self._refresh_exe_fields()   # redraw exe rows to match type
        self.log(f"settings.ini loaded  [{gt}]: {ini_get(lines, 'Name')}")

    def _run_recompile_fix(self):
        self.log("=" * 56)
        self.log("  RECOMPILE FIX STARTED")
        self.log("=" * 56)
        self._run(lambda: work_recompile_fix(self.log, self._dump_log_blocking)
                  and self.log("\n  RECOMPILE FIX COMPLETE!"))

    # ══════════════════════════════════════════════════════════════════════════
    #  TAB 1 — Game Settings
    # ══════════════════════════════════════════════════════════════════════════

    def _build_tab_settings(self, nb):
        outer = tk.Frame(nb, bg=BG)
        nb.add(outer, text="  Game Settings  ")

        # scrollable canvas
        canvas = tk.Canvas(outer, bg=BG, highlightthickness=0)
        vsb    = ttk.Scrollbar(outer, orient="vertical", command=canvas.yview)
        canvas.configure(yscrollcommand=vsb.set)
        vsb.pack(side="right", fill="y")
        canvas.pack(side="left", fill="both", expand=True)

        inner = tk.Frame(canvas, bg=BG)
        win_id = canvas.create_window((0, 0), window=inner, anchor="nw")

        canvas.bind("<Configure>",
                    lambda e: canvas.itemconfig(win_id, width=e.width))
        inner.bind("<Configure>",
                   lambda e: canvas.config(scrollregion=canvas.bbox("all")))
        canvas.bind_all("<MouseWheel>",
                        lambda e: canvas.yview_scroll(-(e.delta // 120), "units"))

        self._settings_inner = inner
        self._populate_settings(inner)

    def _populate_settings(self, p):
        """Fill all widgets into the scrollable settings panel."""

        def section(title):
            tk.Frame(p, bg=BORDER, height=1).pack(fill="x", padx=16, pady=(14, 2))
            tk.Label(p, text=title, bg=BG, fg=ACCENT,
                     font=("Segoe UI", 9, "bold")).pack(anchor="w", padx=18, pady=(0, 4))

        def row(label, var, width=34, **kw):
            f = tk.Frame(p, bg=BG)
            f.pack(fill="x", padx=16, pady=3)
            tk.Label(f, text=label, bg=BG, fg=FG2, width=21, anchor="w",
                     font=("Segoe UI", 10)).pack(side="left")
            e = tk.Entry(f, textvariable=var, bg=ENTRY, fg=FG, width=width,
                         insertbackground=FG, relief="flat",
                         font=("Segoe UI", 10), **kw)
            e.pack(side="left", padx=(0, 4))
            return f

        def browse_row(label, var, isdir=False):
            f = row(label, var, width=32)
            def _go():
                p_ = filedialog.askdirectory(title=label) if isdir \
                     else filedialog.askopenfilename(title=label)
                if p_:
                    var.set(p_)
            _btn(f, "Browse", _go)

        def check_row(label, var):
            f = tk.Frame(p, bg=BG)
            f.pack(fill="x", padx=16, pady=2)
            tk.Checkbutton(f, text=label, variable=var,
                           bg=BG, fg=FG, activebackground=BG,
                           activeforeground=FG, selectcolor=ENTRY,
                           font=("Segoe UI", 10)).pack(anchor="w")

        def _pick_game_dir():
            chosen = filedialog.askdirectory(title="Game Directory")
            if not chosen:
                return
            self.game_dir_var.set(chosen)
            # Calculate size in background so the UI doesn't freeze
            def _calc():
                try:
                    sz = dir_size_str(Path(chosen))
                    self.size_var.set(sz)
                    self.log(f"  Game directory size: {sz}")
                except Exception:
                    pass
            threading.Thread(target=_calc, daemon=True).start()
            # Identify the game from steam_appid.txt + Steam, in the background
            threading.Thread(target=self._autofill_from_game_dir,
                             args=(chosen,), daemon=True).start()

        # ── Repacker identity ────────────────────────────────────────
        section("REPACKER IDENTITY")
        fr = row("Repacker Name", self.repacker_var, width=26)
        _btn(fr, "Save", lambda: self._save_repacker())

        # ── Game info ────────────────────────────────────────────────
        section("GAME INFO")
        gd_f = row("Game Directory", self.game_dir_var, width=32)
        _btn(gd_f, "Browse", _pick_game_dir)
        row("Game Name",        self.name_var)
        row("App ID (Steam)",   self.appid_var)
        row("Build / Version",  self.build_var)
        row("Game Size",        self.size_var, width=18)

        # ── Steam art download (shown only once a Game Directory + App ID
        #    are set — writes icon.ico to the game folder + Setup\,
        #    hero/logo to Setup\, screenshots to Setup\Background, and
        #    auto-fills empty Game Name / Build fields) ──
        self._art_frame = tk.Frame(p, bg=BG)
        self._art_frame.pack(fill="x", padx=16, pady=(6, 2))
        self._art_btn = tk.Button(
            self._art_frame,
            text="⬇  Fetch Art & Metadata   (icon • hero • logo • screenshots)",
            command=self._action_download_steam_art,
            bg=ACCENT, fg="#ffffff",
            activebackground="#4f46e5", activeforeground="#ffffff",
            font=("Segoe UI", 10, "bold"), relief="flat", cursor="hand2",
            padx=10, pady=8)
        self._art_hint = tk.Label(
            self._art_frame,
            text="Choose a Game Directory and enter a Steam App ID to enable "
                 "Steam art download.",
            bg=BG, fg=FG2, font=("Segoe UI", 8))
        # Re-evaluate visibility whenever the directory or App ID changes.
        self.game_dir_var.trace_add("write", self._update_art_button)
        self.appid_var.trace_add("write", self._update_art_button)
        self._update_art_button()

        # ── Game type ────────────────────────────────────────────────
        section("GAME TYPE")
        gt_frame = tk.Frame(p, bg=BG)
        gt_frame.pack(fill="x", padx=16, pady=4)
        for gtype in ("PC", "VR", "VR Optional"):
            tk.Radiobutton(gt_frame, text=gtype, variable=self.game_type_var,
                           value=gtype, bg=BG, fg=FG, activebackground=BG,
                           activeforeground=FG, selectcolor=ENTRY,
                           font=("Segoe UI", 10),
                           command=self._refresh_exe_fields).pack(side="left", padx=10)

        # ── Options ──────────────────────────────────────────────────
        section("OPTIONS")
        check_row("Compact Mode  (skip dir & finish pages)", self.compact_var)
        check_row("Run As Admin  (adds + OFME to package name)", self.admin_var)
        check_row("Info Before screen", self.infobefore_var)

        bat_f = tk.Frame(p, bg=BG)
        bat_f.pack(fill="x", padx=16, pady=2)
        tk.Checkbutton(bat_f, text="Enable Batch file", variable=self.enablebat_var,
                       bg=BG, fg=FG, activebackground=BG, activeforeground=FG,
                       selectcolor=ENTRY, font=("Segoe UI", 10)).pack(side="left")
        tk.Entry(bat_f, textvariable=self.batfile_var, bg=ENTRY, fg=FG, width=22,
                 insertbackground=FG, relief="flat",
                 font=("Segoe UI", 10)).pack(side="left", padx=(8, 4))
        tk.Label(bat_f, text="Batch filename", bg=BG, fg=FG2,
                 font=("Segoe UI", 9)).pack(side="left")

        # ── Executables (dynamic) ────────────────────────────────────
        self.exe_frame = tk.Frame(p, bg=BG)
        self.exe_frame.pack(fill="x")
        self._build_exe_fields()

        # ── Pre-processing ───────────────────────────────────────────
        section("PRE-PROCESSING  (optional)")
        check_row("Rename _o / (Original) files to .AG extension", self.do_rename_var)
        check_row("Sort & reformat DLC.txt",                        self.do_dlc_var)

        # ── Save button ──────────────────────────────────────────────
        sf = tk.Frame(p, bg=BG)
        sf.pack(fill="x", padx=16, pady=14)
        _big_btn(sf, "Save Settings  →  settings.ini",
                 self._action_save_settings, bg=SUCCESS, width=32)

    def _build_exe_fields(self):
        for w in self.exe_frame.winfo_children():
            w.destroy()
        gt = self.game_type_var.get()

        def section(title):
            tk.Frame(self.exe_frame, bg=BORDER, height=1).pack(
                fill="x", padx=16, pady=(14, 2))
            tk.Label(self.exe_frame, text=title, bg=BG, fg=ACCENT,
                     font=("Segoe UI", 9, "bold")).pack(anchor="w", padx=18, pady=(0, 4))

        def exe_row(label, path_var, args_var, show_args=True):
            f = tk.Frame(self.exe_frame, bg=BG)
            f.pack(fill="x", padx=16, pady=3)
            tk.Label(f, text=label, bg=BG, fg=FG2, width=21, anchor="w",
                     font=("Segoe UI", 10)).pack(side="left")
            # When args are hidden the path field takes the freed-up width.
            tk.Entry(f, textvariable=path_var, bg=ENTRY, fg=FG,
                     width=26 if show_args else 46,
                     insertbackground=FG, relief="flat",
                     font=("Segoe UI", 10)).pack(side="left", padx=(0, 6))
            if show_args:
                tk.Label(f, text="Args:", bg=BG, fg=FG2,
                         font=("Segoe UI", 10)).pack(side="left")
                tk.Entry(f, textvariable=args_var, bg=ENTRY, fg=FG, width=16,
                         insertbackground=FG, relief="flat",
                         font=("Segoe UI", 10)).pack(side="left", padx=(4, 0))

        def meta_toggle():
            section("META / OCULUS  (optional)")
            f = tk.Frame(self.exe_frame, bg=BG)
            f.pack(fill="x", padx=16, pady=2)
            tk.Checkbutton(f, text="Include Meta / Oculus shortcut",
                           variable=self.meta_var, bg=BG, fg=FG,
                           activebackground=BG, activeforeground=FG,
                           selectcolor=ENTRY, font=("Segoe UI", 10),
                           command=self._build_exe_fields).pack(anchor="w")

        if gt == "PC":
            section("EXECUTABLE")
            exe_row("EXE Path", self.exe1_var, self.exe1p_var)

        elif gt == "VR":
            section("STEAMVR EXECUTABLE")
            exe_row("SteamVR EXE", self.exe1_var, self.exe1p_var)
            # VD.bat carries its own arguments internally, so it has no Args field.
            section("VIRTUAL DESKTOP LAUNCHER")
            exe_row("VD.bat Path", self.exe2_var, self.exe2p_var, show_args=False)
            tk.Label(self.exe_frame,
                     text="VD.bat is auto-filled next to the SteamVR exe — "
                          "edit it only if the launcher lives elsewhere. "
                          "Arguments are handled inside the .bat, not here.",
                     bg=BG, fg=FG2, font=("Segoe UI", 8),
                     wraplength=560, justify="left").pack(anchor="w", padx=18, pady=(0, 2))
            meta_toggle()
            if self.meta_var.get():
                exe_row("Meta EXE", self.exe3_var, self.exe3p_var)

        elif gt == "VR Optional":
            section("FLAT (2D) EXECUTABLE")
            exe_row("Flat EXE Path", self.exe1_var, self.exe1p_var)
            section("STEAMVR EXECUTABLE")
            exe_row("SteamVR EXE",   self.exe2_var, self.exe2p_var)
            # VD.bat carries its own arguments internally, so it has no Args field.
            section("VIRTUAL DESKTOP LAUNCHER")
            exe_row("VD.bat Path",   self.exe3_var, self.exe3p_var, show_args=False)
            tk.Label(self.exe_frame,
                     text="VD.bat is auto-filled next to the SteamVR exe — "
                          "edit it only if the launcher lives elsewhere. "
                          "Arguments are handled inside the .bat, not here.",
                     bg=BG, fg=FG2, font=("Segoe UI", 8),
                     wraplength=560, justify="left").pack(anchor="w", padx=18, pady=(0, 2))
            meta_toggle()
            if self.meta_var.get():
                exe_row("Meta EXE",  self.exe4_var, self.exe4p_var)

    def _refresh_exe_fields(self):
        self._build_exe_fields()

    # ── VD.bat auto-fill ──────────────────────────────────────────────────────

    @staticmethod
    def _derive_vd_bat(exe_path: str) -> str:
        """Turn a SteamVR exe path into the sibling VD.bat path.

        e.g.  Beyond\\Binaries\\Win64\\Beyond-Win64-Shipping.exe
              → Beyond\\Binaries\\Win64\\VD.bat
        """
        exe_path = (exe_path or "").strip().strip('"')
        if not exe_path:
            return ""
        idx = max(exe_path.rfind("\\"), exe_path.rfind("/"))
        if idx == -1:
            return "VD.bat"
        return exe_path[:idx + 1] + "VD.bat"

    def _apply_vd_autofill(self, steamvr_var, vd_var):
        """Fill vd_var with the derived VD.bat path unless the user has edited it."""
        if self._loading_cfg:
            return
        derived = self._derive_vd_bat(steamvr_var.get())
        current = vd_var.get().strip()
        # Only auto-fill while the field is empty or still holds our last guess;
        # once the user types their own path we leave it alone.
        if current in ("", self._vd_last_auto) and derived != current:
            self._vd_last_auto = derived
            vd_var.set(derived)

    def _autofill_vd_vr(self, *_):
        if self.game_type_var.get() == "VR":
            self._apply_vd_autofill(self.exe1_var, self.exe2_var)

    def _autofill_vd_vropt(self, *_):
        if self.game_type_var.get() == "VR Optional":
            self._apply_vd_autofill(self.exe2_var, self.exe3_var)

    # ══════════════════════════════════════════════════════════════════════════
    #  TAB 2 — Build & Pack
    # ══════════════════════════════════════════════════════════════════════════

    def _build_tab_build(self, nb):
        frame = tk.Frame(nb, bg=BG)
        nb.add(frame, text="  Build & Pack  ")

        # ── Compression preset ───────────────────────────────────────
        cp = tk.Frame(frame, bg=PANEL, padx=16, pady=12)
        cp.pack(fill="x", padx=12, pady=(12, 6))
        tk.Label(cp, text="Compression Preset", bg=PANEL, fg=FG,
                 font=("Segoe UI", 11, "bold")).pack(anchor="w", pady=(0, 8))
        presets = [
            ("12  –  Maximum  (LOLZ + SREP + XTool)", "12"),
            ("8   –  High     (LOLZ + SREP)",          "8"),
            ("4   –  Medium   (LOLZ only)",             "4"),
            ("0   –  Store    (no compression, fastest)","0"),
        ]
        for label, val in presets:
            tk.Radiobutton(cp, text=label, variable=self.preset_var, value=val,
                           bg=PANEL, fg=FG, activebackground=PANEL,
                           activeforeground=FG, selectcolor=ENTRY,
                           font=("Cascadia Code", 10)).pack(anchor="w", pady=1)

        # ── Full-run (the normal, one-click path) ────────────────────
        sep = tk.Frame(frame, bg=BORDER, height=1)
        sep.pack(fill="x", padx=12, pady=12)

        run_outer = tk.Frame(frame, bg=BG)
        run_outer.pack(pady=4)
        _big_btn(run_outer, "  ▶   RUN FULL REPACK   ◀  ",
                 self._action_full_repack, bg=ACCENT, fg="#ffffff",
                 font=("Segoe UI", 13, "bold"), width=38, pady=12)
        tk.Label(frame,
                 text="Pre-Process  →  Save INI  →  Compile  →  Compress  "
                      "→  Create DLL  →  Merge  →  Zip  →  Archive Art",
                 bg=BG, fg=FG2, font=("Segoe UI", 8)).pack(pady=(2, 4))

        # ── Manual steps (hidden until explicitly revealed) ──────────
        # The individual step buttons and the Recompile Fix are only needed
        # when the full repack above hits a problem — they stay hidden behind
        # this toggle so the normal flow is just the one button.
        sep2 = tk.Frame(frame, bg=BORDER, height=1)
        sep2.pack(fill="x", padx=12, pady=(12, 4))

        toggle_outer = tk.Frame(frame, bg=BG)
        toggle_outer.pack(pady=4)
        self._manual_shown  = False
        self._manual_warned = False
        self._manual_btn = tk.Button(
            toggle_outer, text="⚙  Manual Steps  ▾",
            command=self._toggle_manual_steps,
            bg=BTN, fg=FG, activebackground=BTN, activeforeground=FG,
            relief="flat", cursor="hand2", bd=0, padx=14, pady=6,
            font=("Segoe UI", 10, "bold"))
        self._manual_btn.pack()

        # Container built now but not packed — _toggle_manual_steps packs it.
        self._manual_frame = tk.Frame(frame, bg=BG)

        warn = tk.Label(
            self._manual_frame,
            text="⚠  In most cases you will never need these. Only use them if "
                 "the full repack above has an issue and you know what you're "
                 "doing — running steps out of order can produce a broken repack.",
            bg=BG, fg=WARN, font=("Segoe UI", 8, "bold"),
            wraplength=680, justify="left")
        warn.pack(anchor="w", padx=16, pady=(4, 6))

        # Individual step buttons
        steps_lbl = tk.Frame(self._manual_frame, bg=BG)
        steps_lbl.pack(fill="x", padx=12, pady=(4, 4))
        tk.Label(steps_lbl, text="Individual Steps", bg=BG, fg=ACCENT,
                 font=("Segoe UI", 10, "bold")).pack(anchor="w", padx=4)

        grid = tk.Frame(self._manual_frame, bg=BG)
        grid.pack(fill="x", padx=16, pady=4)
        grid.columnconfigure(0, weight=1)
        grid.columnconfigure(1, weight=1)

        step_defs = [
            ("1.  Pre-Process Files",        self._step_preprocess,     BTN),
            ("2.  Save Settings → INI",      self._action_save_settings, BTN),
            ("3.  Compile Script  (IS)",     self._step_compile,        BTN),
            ("4.  Compress Game Data",       self._step_compress,       BTN),
            ("5.  Create DLL (+ Records)",   self._step_create_dll,     BTN),
            ("6.  Merge DLL into EXE",       self._step_internal_dll,   BTN),
            ("7.  Zip & Name Package",       self._step_zip,            BTN),
            ("8.  Archive Game Art",         self._step_archive_art,    BTN),
        ]
        for i, (label, cmd, color) in enumerate(step_defs):
            r, c = divmod(i, 2)
            cell = tk.Frame(grid, bg=BG)
            cell.grid(row=r, column=c, padx=5, pady=4, sticky="ew")
            _big_btn(cell, label, cmd, bg=color, width=30, fill="x")

        # Recompile Fix
        sep3 = tk.Frame(self._manual_frame, bg=BORDER, height=1)
        sep3.pack(fill="x", padx=12, pady=(8, 4))
        fix_outer = tk.Frame(self._manual_frame, bg=BG)
        fix_outer.pack(pady=2)
        _big_btn(fix_outer, "  ↺  Recompile Fix  ",
                 self._run_recompile_fix, bg=WARN, fg="#000000",
                 font=("Segoe UI", 10, "bold"), width=26, pady=7)
        tk.Label(self._manual_frame,
                 text="Use when data.bin + DLL are already done — moves files from Setup\\, "
                      "recompiles, merges, zips, archives.",
                 bg=BG, fg=FG2, font=("Segoe UI", 8), wraplength=680).pack(pady=(0, 10))

    def _toggle_manual_steps(self):
        """Show/hide the advanced manual-step buttons, warning on first reveal."""
        if self._manual_shown:
            self._manual_frame.pack_forget()
            self._manual_shown = False
            self._manual_btn.config(text="⚙  Manual Steps  ▾")
            return

        if not self._manual_warned:
            proceed = messagebox.askokcancel(
                "Manual Steps",
                "These buttons run each stage of the repack by hand.\n\n"
                "In most cases you will NEVER need them — the RUN FULL REPACK "
                "button does everything in the right order.\n\n"
                "Only use them if the full repack has an issue and you know "
                "what you're doing. Running steps out of order can produce a "
                "broken repack.\n\nShow the manual steps anyway?",
                icon="warning")
            if not proceed:
                return
            self._manual_warned = True

        self._manual_frame.pack(fill="x", padx=0, pady=(2, 0))
        self._manual_shown = True
        self._manual_btn.config(text="⚙  Manual Steps  ▴")

    # ══════════════════════════════════════════════════════════════════════════
    #  Action helpers
    # ══════════════════════════════════════════════════════════════════════════

    def log(self, msg: str):
        def _write():
            self.log_box.config(state="normal")
            self.log_box.insert("end", msg + "\n")
            self.log_box.see("end")
            self.log_box.config(state="disabled")
        self.root.after(0, _write)

    def dump_log_to_file(self) -> None:
        """Grab log_box text on the main thread and save it for archiving.
        Must be called from the main thread (or via root.after)."""
        self.log_box.config(state="normal")
        text = self.log_box.get("1.0", "end")
        self.log_box.config(state="disabled")
        save_repack_log(text, self.log)

    def _dump_log_blocking(self) -> None:
        """Call dump_log_to_file on the main thread and block until it runs.
        Safe to call from a background worker thread."""
        done = threading.Event()
        self.root.after(0, lambda: (self.dump_log_to_file(), done.set()))
        done.wait()

    def _run(self, fn, *args):
        """Run fn(*args) in a daemon thread.

        Any exception is reported in the GUI log (and a dialog) instead of being
        printed to a console that a --windowed build does not have — otherwise a
        crashed worker just vanishes with no trace.
        """
        def _guarded():
            try:
                fn(*args)
            except Exception:
                import traceback
                tb = traceback.format_exc()
                self.log("[ERROR] Unexpected error — the step did not finish:")
                for line in tb.rstrip().splitlines():
                    self.log("    " + line)
                self.root.after(0, lambda: messagebox.showerror(
                    "Unexpected Error",
                    "Something went wrong during this step:\n\n"
                    + tb.strip().splitlines()[-1]
                    + "\n\nSee the log for details."))
        threading.Thread(target=_guarded, daemon=True).start()

    def _ask_continue(self, step: str, detail: str) -> bool:
        """
        Show a blocking warning dialog from a background thread.
        Returns True if the user chooses to continue, False to stop.
        """
        result = [False]
        event  = threading.Event()
        def _show():
            ans = messagebox.askquestion(
                f"Step Failed — {step}",
                f"{detail}\n\n"
                "This error may produce a broken repack.\n\n"
                "Continue to the next step anyway?\n"
                "(Choosing NO will stop the full repack here.)",
                icon="warning",
            )
            result[0] = (ans == "yes")
            event.set()
        self.root.after(0, _show)
        event.wait()
        return result[0]

    def _fields(self) -> dict:
        return {
            "repacker":   self.repacker_var.get().strip(),
            "name":       self.name_var.get().strip(),
            "appid":      self.appid_var.get().strip(),
            "build":      self.build_var.get().strip(),
            "size":       self.size_var.get().strip(),
            "compact":    self.compact_var.get(),
            "admin":      self.admin_var.get(),
            "infobefore": self.infobefore_var.get(),
            "enablebat":  self.enablebat_var.get(),
            "batfile":    self.batfile_var.get().strip(),
            "exe1":       self.exe1_var.get().strip(),
            "exe1p":      self.exe1p_var.get().strip(),
            "exe2":       self.exe2_var.get().strip(),
            "exe2p":      self.exe2p_var.get().strip(),
            "exe3":       self.exe3_var.get().strip(),
            "exe3p":      self.exe3p_var.get().strip(),
            "exe4":       self.exe4_var.get().strip(),
            "exe4p":      self.exe4p_var.get().strip(),
            "meta":       self.meta_var.get(),
        }

    def _save_repacker(self):
        name = self.repacker_var.get().strip()
        if name:
            save_repacker(name)
            self.log(f"Repacker name saved: {name}")
        else:
            messagebox.showwarning("No name", "Enter a repacker name first.")

    def _require(self, *keys) -> bool:
        labels = {"name": "Game Name", "game_dir": "Game Directory"}
        for k in keys:
            var = getattr(self, f"{k}_var", None)
            if var is None or not var.get().strip():
                messagebox.showwarning("Required Field",
                                       f"'{labels.get(k, k)}' is required.")
                return False
        return True

    # ── Auto-identify game from folder ────────────────────────────────────────

    def _autofill_from_game_dir(self, chosen: str):
        """Scan the chosen folder (+ subfolders) for steam_appid.txt and, if
        found, pull the App ID / Game Name / newest Build id from Steam and fill
        in any fields the user hasn't already set. Runs on a background thread.

        The build id is Steam's *newest* public build — it's only a best guess
        for the copy being repacked, so it's left editable for correction."""
        game_path = Path(chosen)
        appid = find_steam_appid(game_path)
        if not appid:
            self.log("  No steam_appid.txt found under the game directory — "
                     "enter the Steam App ID manually to fetch metadata.")
            return
        self.log(f"  Found steam_appid.txt  →  App ID {appid}")

        def _set_appid():
            if not self.appid_var.get().strip():
                self.appid_var.set(appid)
                self.log(f"  Auto-filled App ID: {appid}")
        self.root.after(0, _set_appid)

        # Store name
        details = steam_get_appdetails(appid, self.log)
        name = (details.get("name") or "").strip()

        # Newest public build id, falling back to the installed manifest's build
        buildid = steam_get_latest_buildid(appid, self.log)
        build_src = "Steam newest build"
        if not buildid:
            buildid = _read_steam_buildid(game_path, appid)
            build_src = "installed Steam manifest"

        def _apply():
            if name and not self.name_var.get().strip():
                self.name_var.set(name)
                self.log(f"  Auto-filled Game Name: {name}")
            if buildid and not self.build_var.get().strip():
                self.build_var.set(buildid)
                self.log(f"  Auto-filled Build / Version: {buildid}  "
                         f"[{build_src}] — correct it if this isn't the "
                         f"build you're repacking.")
        self.root.after(0, _apply)

    # ── Steam art download ────────────────────────────────────────────────────

    def _update_art_button(self, *_):
        """Show the Steam-art button only when a Game Directory is chosen and a
        numeric App ID has been entered; otherwise show a short hint."""
        # Guard: trace fires during startup before the widgets exist.
        if not hasattr(self, "_art_btn"):
            return
        have_dir   = bool(self.game_dir_var.get().strip())
        have_appid = self.appid_var.get().strip().isdigit()
        if have_dir and have_appid:
            self._art_hint.pack_forget()
            self._art_btn.pack(fill="x")
        else:
            self._art_btn.pack_forget()
            self._art_hint.pack(anchor="w")

    def _action_download_steam_art(self):
        gd    = self.game_dir_var.get().strip()
        appid = self.appid_var.get().strip()
        if not gd or not appid.isdigit():
            messagebox.showwarning(
                "Required",
                "Set a Game Directory and a numeric Steam App ID first.")
            return
        exe_hint = self.exe1_var.get().strip()

        def apply_meta(name, buildid):
            def _set():
                if name and not self.name_var.get().strip():
                    self.name_var.set(name)
                    self.log(f"  Auto-filled Game Name: {name}")
                if buildid and not self.build_var.get().strip():
                    self.build_var.set(buildid)
                    self.log(f"  Auto-filled Build / Version: {buildid}")
            self.root.after(0, _set)

        self.log(f"Downloading Steam art for App ID {appid} ...")
        self._run(work_download_steam_art, appid, gd, exe_hint,
                  self.log, apply_meta)

    # ── Single-step wrappers ──────────────────────────────────────────────────

    def _action_save_settings(self):
        if not self._require("name"):
            return
        fields = self._fields()
        gt     = self.game_type_var.get()
        self.log(f"Saving settings.ini for [{gt}]: {fields['name']} ...")
        self._run(lambda: work_build_settings(gt, fields, self.log)
                  and self.log("  Done."))

    def _step_preprocess(self):
        gd = self.game_dir_var.get().strip()
        if not gd:
            self.log("[SKIP] No game directory set.")
            return
        if self.do_rename_var.get():
            self.log("Renaming _o / (Original) files...")
            self._run(work_rename_originals, gd, self.log)
        if self.do_dlc_var.get():
            self.log("Sorting DLC.txt...")
            self._run(work_sort_dlc, gd, self.log)

    def _step_compile(self):
        self.log("Checking Finish.bmp...")
        self._run(work_copy_finish_bmp, self.log)
        self.log("Launching Inno Setup compiler...")
        self._run(work_compile_gui, self.log)

    def _step_compress(self):
        gd = self.game_dir_var.get().strip()
        if not gd:
            messagebox.showwarning("Required", "Set the Game Directory first.")
            return
        preset = self.preset_var.get()
        self.log(f"Compressing game data (preset {preset}) — this takes a while...")
        self._run(lambda: work_compress(preset, gd, self.log))

    def _step_create_dll(self):
        preset = self.preset_var.get()
        self.log(f"Creating DLL (preset {preset})...")
        def _work():
            work_records(preset, self.log)
            work_create_dll(preset, self.log)
        self._run(_work)

    def _step_internal_dll(self):
        self.log("Merging DLL into Setup EXE...")
        self._run(work_internal_dll, self.log, False)

    def _step_zip(self):
        self.log("Zipping final package...")
        self._run(work_zip_and_name, self.log)

    def _step_archive_art(self):
        self.log("Archiving game art...")
        self.log("  Saving repack log...")
        self._dump_log_blocking()
        self._run(work_archive_art, self.log)

    # ── Full repack ───────────────────────────────────────────────────────────

    def _action_full_repack(self):
        if not self._require("name"):
            return
        gd = self.game_dir_var.get().strip()
        if not gd:
            messagebox.showwarning("Required", "Game Directory is required.")
            return

        # ── Capture ALL GUI values HERE on the main thread ──────────────────
        # tkinter StringVar / BooleanVar are not thread-safe; reading them
        # inside a background thread can silently return empty strings.
        fields    = self._fields()
        gt        = self.game_type_var.get()
        preset    = self.preset_var.get()
        do_rename = self.do_rename_var.get()
        do_dlc    = self.do_dlc_var.get()
        # ────────────────────────────────────────────────────────────────────

        def _full():
            self.log("=" * 56)
            self.log("  FULL REPACK STARTED")
            self.log("=" * 56)

            # 1 — Pre-process
            did_pre = False
            if do_rename:
                self.log("\n[1/8] Renaming _o / (Original) files...")
                work_rename_originals(gd, self.log)
                did_pre = True
            if do_dlc:
                self.log("\n[1/8] Sorting DLC.txt...")
                work_sort_dlc(gd, self.log)
                did_pre = True
            if not did_pre:
                self.log("\n[1/8] Pre-process skipped.")

            # 2 — Settings
            self.log("\n[2/8] Writing settings.ini...")
            if not work_build_settings(gt, fields, self.log):
                self.log("[STOP] settings.ini could not be written — aborting.")
                return

            # Verify the name was actually written before we compile
            verify_lines = ini_read(SETTINGS_INI)
            written_name = ini_get(verify_lines, "Name")
            if not written_name:
                self.log("[STOP] settings.ini Name field is empty after write — aborting.")
                self.log("       Check that the template INI file exists and is readable.")
                return
            self.log(f"  Verified: Name = '{written_name}'")

            # 3 — Compile
            self.log("\n[3/8] Compiling Inno Setup script...")
            work_copy_finish_bmp(self.log)
            ok = work_compile_blocking(self.log)
            if not ok:
                if not self._ask_continue(
                    "Step 3 — Compile",
                    "The Inno Setup compiler returned an error.\n"
                    "The Setup EXE may not have been built correctly."
                ):
                    self.log("[STOP] Repack stopped at user request after compile failure.")
                    return

            # 4 — Compress
            self.log(f"\n[4/8] Compressing game data (preset {preset})...")
            ok = work_compress(preset, gd, self.log)
            if not ok:
                if not self._ask_continue(
                    "Step 4 — Compress",
                    "The compression step failed or returned an error."
                ):
                    self.log("[STOP] Repack stopped at user request after compression failure.")
                    return

            # 5 — Records + DLL
            self.log("\n[5/8] Creating AGRepackInstaller.dll...")
            ok = work_records(preset, self.log)
            if not ok:
                if not self._ask_continue("Step 5 — Records", "Records.ini could not be created."):
                    self.log("[STOP] Repack stopped at user request.")
                    return
            ok = work_create_dll(preset, self.log)
            if not ok:
                if not self._ask_continue(
                    "Step 5 — Create DLL",
                    "AGRepackInstaller.dll could not be built by Arc."
                ):
                    self.log("[STOP] Repack stopped at user request.")
                    return

            # 6 — Merge DLL into EXE
            self.log("\n[6/8] Merging DLL into Setup EXE...")
            ok = work_internal_dll(self.log, blocking_compile=True)
            if not ok:
                if not self._ask_continue(
                    "Step 6 — Merge DLL",
                    "The DLL merge step encountered an error."
                ):
                    self.log("[STOP] Repack stopped at user request.")
                    return

            # 7 — Zip
            self.log("\n[7/8] Zipping final package...")
            work_zip_and_name(self.log)

            # 8 — Archive art (log saved first so it's bundled in)
            self.log("\n[8/8] Archiving game art...")
            self.log("  Saving repack log...")
            self._dump_log_blocking()
            work_archive_art(self.log)

            self.log("\n" + "=" * 56)
            self.log("  REPACK COMPLETE!")
            self.log("=" * 56)
            self.root.after(0, lambda: messagebox.showinfo(
                "Done", "Repack complete!\nAll files have been packaged and archived."))

        self._run(_full)


# ═══════════════════════════════════════════════════════════════════════════
#  Widget factories
# ═══════════════════════════════════════════════════════════════════════════

def _big_btn(parent, text, command,
             bg=BTN, fg=FG, font=None, width=22, fill=None, pady=7, **kw):
    f = font or ("Segoe UI", 10, "bold")
    b = tk.Button(parent, text=text, command=command,
                  bg=bg, fg=fg,
                  activebackground=ACCENT, activeforeground="#ffffff",
                  font=f, relief="flat", cursor="hand2",
                  padx=10, pady=pady, width=width, **kw)
    if fill:
        b.pack(fill=fill)
    else:
        b.pack()
    return b


def _btn(parent, text, command):
    tk.Button(parent, text=text, command=command,
              bg=BTN, fg=FG,
              activebackground=ACCENT, activeforeground="#ffffff",
              font=("Segoe UI", 9), relief="flat", cursor="hand2",
              padx=8, pady=3).pack(side="left", padx=(4, 0))


# ═══════════════════════════════════════════════════════════════════════════
#  Entry point
# ═══════════════════════════════════════════════════════════════════════════

if __name__ == "__main__":
    if "--version" in sys.argv or "-V" in sys.argv:
        print(f"AG Repack GUI v{__version__}")
        sys.exit(0)
    root = tk.Tk()
    app  = RepackApp(root)
    root.mainloop()
