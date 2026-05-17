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
import subprocess
import threading
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
from pathlib import Path


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


def write_temp(filename: str, value: str):
    import tempfile
    p = Path(tempfile.gettempdir()) / filename
    p.write_text(value + " \n", encoding="utf-8")


# ── Pre-processing ───────────────────────────────────────────────────────────

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
    # Ensure destination folders exist before the bat tries to move/copy into them
    CONVERSION_DIR.mkdir(parents=True, exist_ok=True)
    write_temp("dir.tmp",       game_dir)
    write_temp("directory.tmp", str(BASE_DIR))
    write_temp("preset.tmp",    preset)
    log(f"  Running compression preset {preset} — this will take a while...")
    log("  (watch the CMD window for Arc progress; press any key when it shows PAUSE)")
    r = subprocess.run(str(bat), cwd=str(BASE_DIR), shell=True)
    if r.returncode != 0:
        log(f"[WARN] Compression bat returned code {r.returncode}")
    else:
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
        src = SETUP_DIR / fname
        if src.exists():
            shutil.move(str(src), str(bg_dir / fname))

    if SETTINGS_INI.exists():
        shutil.move(str(SETTINGS_INI), str(bg_dir / "settings.ini"))

    zip_path = BASE_DIR / f"{arc_name}.7z"
    cmd = [str(SEVEN_ZIP), "a", "-t7z", "-mx=9", "-sdel",
           str(zip_path), str(bg_dir / "*"),
           "-xr!*\\*", "-xr!_OldGameArt", "-xr!_OldGameArt\\*"]
    log(f"  Archiving game art as: {arc_name}.7z")
    subprocess.run(cmd, cwd=str(BASE_DIR))

    if zip_path.exists():
        shutil.move(str(zip_path), str(old_art / zip_path.name))
        log(f"  Art archive saved: {old_art / zip_path.name}")

    leftover = SETUP_DIR / "settings.ini"
    if leftover.exists():
        leftover.unlink()

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
#  GUI
# ═══════════════════════════════════════════════════════════════════════════

class RepackApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("DMPRepack GUI  –  ARMGDDN Games")
        self.root.configure(bg=BG)
        self.root.minsize(860, 700)
        self._busy = False

        self._init_vars()
        self._apply_styles()
        self._build_ui()
        self.repacker_var.set(get_repacker())
        # Run startup check after the window is fully drawn
        self.root.after(150, self._check_existing_settings)

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
        tk.Label(hdr, text="DMPRepack GUI", bg="#0a0f1e", fg=ACCENT,
                 font=("Segoe UI", 16, "bold")).pack(side="left", padx=16)
        tk.Label(hdr, text="ARMGDDN Games  //  Repack Tool",
                 bg="#0a0f1e", fg=FG2, font=("Segoe UI", 10)).pack(side="left")

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

    def _check_existing_settings(self):
        if not SETTINGS_INI.exists():
            return

        # Offer to load existing values into the form
        load = messagebox.askyesno(
            "Existing settings.ini Found",
            "Found an existing settings.ini next to the tool.\n\n"
            "Load its values into the form?\n"
            "(Useful when resuming an interrupted repack)",
            icon="question",
        )
        if load:
            self._load_settings_ini()

        # Ask about the Recompile Fix workflow
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
            # Only warn about missing data.bin when they actually intend to run a fix
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

        def exe_row(label, path_var, args_var):
            f = tk.Frame(self.exe_frame, bg=BG)
            f.pack(fill="x", padx=16, pady=3)
            tk.Label(f, text=label, bg=BG, fg=FG2, width=21, anchor="w",
                     font=("Segoe UI", 10)).pack(side="left")
            tk.Entry(f, textvariable=path_var, bg=ENTRY, fg=FG, width=26,
                     insertbackground=FG, relief="flat",
                     font=("Segoe UI", 10)).pack(side="left", padx=(0, 6))
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
            section("VIRTUAL DESKTOP LAUNCHER")
            exe_row("VD.bat Path", self.exe2_var, self.exe2p_var)
            meta_toggle()
            if self.meta_var.get():
                exe_row("Meta EXE", self.exe3_var, self.exe3p_var)

        elif gt == "VR Optional":
            section("FLAT (2D) EXECUTABLE")
            exe_row("Flat EXE Path", self.exe1_var, self.exe1p_var)
            section("STEAMVR EXECUTABLE")
            exe_row("SteamVR EXE",   self.exe2_var, self.exe2p_var)
            section("VIRTUAL DESKTOP LAUNCHER")
            exe_row("VD.bat Path",   self.exe3_var, self.exe3p_var)
            meta_toggle()
            if self.meta_var.get():
                exe_row("Meta EXE",  self.exe4_var, self.exe4p_var)

    def _refresh_exe_fields(self):
        self._build_exe_fields()

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

        # ── Individual step buttons ──────────────────────────────────
        steps_lbl = tk.Frame(frame, bg=BG)
        steps_lbl.pack(fill="x", padx=12, pady=(8, 4))
        tk.Label(steps_lbl, text="Individual Steps", bg=BG, fg=ACCENT,
                 font=("Segoe UI", 10, "bold")).pack(anchor="w", padx=4)

        grid = tk.Frame(frame, bg=BG)
        grid.pack(fill="x", padx=16, pady=4)
        grid.columnconfigure(0, weight=1)
        grid.columnconfigure(1, weight=1)

        step_defs = [
            ("Pre-Process Files",       self._step_preprocess,   BTN),
            ("Save Settings → INI",     self._action_save_settings, BTN),
            ("Compile Script  (IS)",    self._step_compile,      BTN),
            ("Compress Game Data",      self._step_compress,     BTN),
            ("Create DLL",             self._step_create_dll,   BTN),
            ("Merge DLL into EXE",     self._step_internal_dll, BTN),
            ("Zip & Name Package",     self._step_zip,          BTN),
            ("Archive Game Art",       self._step_archive_art,  BTN),
        ]
        for i, (label, cmd, color) in enumerate(step_defs):
            r, c = divmod(i, 2)
            cell = tk.Frame(grid, bg=BG)
            cell.grid(row=r, column=c, padx=5, pady=4, sticky="ew")
            _big_btn(cell, label, cmd, bg=color, width=30, fill="x")

        # ── Full-run ─────────────────────────────────────────────────
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

        # ── Recompile Fix ─────────────────────────────────────────────
        sep2 = tk.Frame(frame, bg=BORDER, height=1)
        sep2.pack(fill="x", padx=12, pady=(8, 4))
        fix_outer = tk.Frame(frame, bg=BG)
        fix_outer.pack(pady=2)
        _big_btn(fix_outer, "  ↺  Recompile Fix  ",
                 self._run_recompile_fix, bg=WARN, fg="#000000",
                 font=("Segoe UI", 10, "bold"), width=26, pady=7)
        tk.Label(frame,
                 text="Use when data.bin + DLL are already done — moves files from Setup\\, "
                      "recompiles, merges, zips, archives.",
                 bg=BG, fg=FG2, font=("Segoe UI", 8), wraplength=680).pack(pady=(0, 10))

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
        """Run fn(*args) in a daemon thread."""
        threading.Thread(target=fn, args=args, daemon=True).start()

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
    root = tk.Tk()
    app  = RepackApp(root)
    root.mainloop()
