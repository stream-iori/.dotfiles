#!/usr/bin/env python3
"""Close the focused pane, tab, or (with confirmation) session."""
import json
import os
import subprocess
import sys


def run(*args):
    return subprocess.run([os.environ.get("HERDR_BIN_PATH", "herdr"), *args],
                          check=True, capture_output=True, text=True)


def query(*args):
    return json.loads(run(*args).stdout)


def context():
    workspace = os.environ["HERDR_ACTIVE_WORKSPACE_ID"]
    tab = os.environ["HERDR_ACTIVE_TAB_ID"]
    pane = os.environ["HERDR_ACTIVE_PANE_ID"]
    tabs = query("tab", "list", "--workspace", workspace)["result"]["tabs"]
    current = next(t for t in tabs if t["tab_id"] == tab)
    return workspace, tab, pane, tabs, current


def main():
    workspace, tab, pane, tabs, current = context()
    if current["pane_count"] > 1:
        run("pane", "close", pane)
    elif len(tabs) > 1:
        run("tab", "close", tab)
    else:
        socket = os.path.realpath(os.environ["HERDR_SOCKET_PATH"])
        sessions = query("session", "list", "--json")["sessions"]
        session = next(s["name"] for s in sessions
                       if os.path.realpath(s["socket_path"]) == socket and s["running"])
        print(f"关闭最后一个 tab 并停止 session '{session}'？")
        print("其他 workspace 中的进程也会结束。输入 yes 确认：", end="", flush=True)
        if input().strip() != "yes":
            return
        # Recheck before launching the independent cleanup process.
        _, _, _, fresh_tabs, fresh = context()
        if len(fresh_tabs) != 1 or fresh["pane_count"] != 1:
            raise RuntimeError("布局已变化，请重新操作")
        subprocess.Popen([sys.executable, __file__, "--finish", tab, session],
                         stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
                         stderr=subprocess.DEVNULL, start_new_session=True)


try:
    if len(sys.argv) == 4 and sys.argv[1] == "--finish":
        run("tab", "close", sys.argv[2])
        run("session", "stop", sys.argv[3])
    else:
        main()
except (Exception, KeyboardInterrupt) as exc:
    print(f"\n操作未完成：{exc}")
    try:
        input("按 Enter 关闭。")
    except (EOFError, KeyboardInterrupt):
        pass
