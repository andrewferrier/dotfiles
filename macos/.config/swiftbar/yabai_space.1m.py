#!/usr/bin/env python3
# coding=utf-8
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

import subprocess
import json

BLUE = "\\\\e[0;34m"
RESET = "\\\\e[0m"

windows = json.loads(
    subprocess.run(
        ["yabai", "-m", "query", "--windows"], stdout=subprocess.PIPE
    ).stdout
)

spaces = json.loads(
    subprocess.run(
        ["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE
    ).stdout
)

space_focused = [space for (space) in spaces if space["has-focus"]][0]["index"]

spaces_display = [
    window["space"]
    for (window) in windows
    if (not window["is-hidden"] and not window["is-minimized"])
] + [space_focused]

spaces_display = sorted(set(spaces_display))

spaces_display = map(
    lambda space: f"{BLUE}{space}{RESET}"
    if space == space_focused
    else f"{space}",
    spaces_display,
)

print("🖥️ " + " ".join(spaces_display) + " | ansi=true")
