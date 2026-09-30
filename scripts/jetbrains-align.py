#!/usr/bin/env python3
"""Apply IDE settings and completion keys required by the shared IdeaVim keymap.

Run after quitting IDEA/PyCharm. Existing XML options and keymaps are preserved.
"""

from datetime import datetime
from pathlib import Path
import shutil
import subprocess
import xml.etree.ElementTree as ET


SETTINGS = (
    ("git.xml", "Git.Application.Settings", "STAGING_AREA_ENABLED", "true"),
    ("editor.xml", "DaemonCodeAnalyzerSettings", "NEXT_ERROR_ACTION_GOES_TO_ERRORS_FIRST", "false"),
)


def write_xml(path, root):
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists():
        stamp = datetime.now().strftime("%Y%m%d-%H%M%S-%f")
        shutil.copy2(path, path.with_name(f"{path.name}.alignment-{stamp}.bak"))
    ET.indent(root, space="  ")
    temporary = path.with_suffix(".alignment.tmp")
    temporary.write_text(ET.tostring(root, encoding="unicode") + "\n")
    temporary.replace(path)


def align_completion(profile):
    active_path = profile / "options/mac/keymap.xml"
    if not active_path.exists():
        active_path = profile / "options/keymap.xml"
    active = ET.parse(active_path).getroot() if active_path.exists() else ET.Element("application")
    manager = active.find("./component[@name='KeymapManager']")
    if manager is None:
        manager = ET.SubElement(active, "component", name="KeymapManager")
    selected = manager.find("active_keymap")
    if selected is None:
        selected = ET.SubElement(manager, "active_keymap", name="Mac OS X 10.5+")
    name = selected.get("name")
    keymap_path = None
    for candidate in (profile / "keymaps").glob("*.xml"):
        keymap = ET.parse(candidate).getroot()
        if keymap.get("name") == name:
            keymap_path = candidate
            break
    if keymap_path is None:
        keymap = ET.Element("keymap", version="1", name=f"{name} Vim", parent=name)
        keymap_path = profile / "keymaps" / "vim-aligned.xml"
        selected.set("name", keymap.get("name"))
        write_xml(active_path, active)
    before = ET.tostring(keymap)
    choose = keymap.find("./action[@id='EditorChooseLookupItem']")
    if choose is None:
        choose = ET.SubElement(keymap, "action", id="EditorChooseLookupItem")
    # Override the inherited Enter confirmation, retaining other custom shortcuts.
    for shortcut in list(choose):
        if shortcut.get("first-keystroke", "").upper() == "ENTER":
            choose.remove(shortcut)
    if not any(shortcut.get("first-keystroke", "").upper() == "TAB" for shortcut in choose):
        ET.SubElement(choose, "keyboard-shortcut", **{"first-keystroke": "TAB"})
    # Native Tab normally replaces the identifier suffix. Use ordinary acceptance.
    replace = keymap.find("./action[@id='EditorChooseLookupItemReplace']")
    if replace is None:
        replace = ET.SubElement(keymap, "action", id="EditorChooseLookupItemReplace")
    for shortcut in list(replace):
        if shortcut.get("first-keystroke", "").upper() == "TAB":
            replace.remove(shortcut)
    if before != ET.tostring(keymap):
        write_xml(keymap_path, keymap)
        return [str(keymap_path.relative_to(profile))]
    return []


def apply_profile(profile):
    changed = []
    for filename, component_name, option_name, value in SETTINGS:
        path = profile / "options" / filename
        parser = ET.XMLParser(target=ET.TreeBuilder(insert_comments=True))
        root = ET.parse(path, parser=parser).getroot() if path.exists() else ET.Element("application")
        component = root.find(f"./component[@name='{component_name}']")
        if component is None:
            component = ET.SubElement(root, "component", name=component_name)
        option = component.find(f"./option[@name='{option_name}']")
        if option is not None and option.get("value") == value:
            continue
        if option is None:
            option = ET.SubElement(component, "option", name=option_name)
        option.set("value", value)
        write_xml(path, root)
        changed.append(filename)
    changed.extend(align_completion(profile))
    return changed


def main():
    root = Path.home() / "Library/Application Support/JetBrains"
    # Running IDEs own their settings and may overwrite changes on exit.
    processes = subprocess.check_output(["ps", "-axo", "comm="], text=True).splitlines()
    pending = False
    for pattern, executable in (("IntelliJIdea*", "idea"), ("PyCharm*", "pycharm")):
        running = any(Path(line.strip()).name == executable for line in processes)
        for profile in sorted(root.glob(pattern)):
            if not profile.is_dir():
                continue
            if running:
                print(f"PENDING {profile.name}: quit {executable}, then rerun this script")
                pending = True
                continue
            changed = apply_profile(profile)
            print(f"OK {profile.name}: {', '.join(changed) if changed else 'already aligned'}")
    return 1 if pending else 0


if __name__ == "__main__":
    raise SystemExit(main())
