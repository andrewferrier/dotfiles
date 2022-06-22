#!/usr/bin/env python3
# coding=utf-8
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

import subprocess
import json


def find_display(space_index):
    space_focused = [
        space["display"] for space in spaces if space["index"] == space_index
    ][0]
    return space_focused


def find_color(space):
    if space == space_focused:
        return f"{BLUE}{space}{RESET}"
    else:
        display = find_display(space)

        if display == 1:
            return f"{BLACK}{space}{RESET}"
        else:
            return f"{GREEN}{space}{RESET}"


def has_visible_windows(space):
    windows = json.loads(
        subprocess.run(
            ["yabai", "-m", "query", "--windows", "--space", str(space)],
            stdout=subprocess.PIPE,
        ).stdout
    )

    # Cannot use 'is-visible' because when you are on another space they are considered not visible.
    visible_window_list = [
        window
        for window in windows
        if window["is-minimized"] == False and window["is-hidden"] == False
    ]

    return len(visible_window_list) > 0


BLUE = "\\\\e[0;34m"
BLACK = "\\\\e[0;30m"
GREEN = "\\\\e[0;35m"
RESET = "\\\\e[0m"

spaces = json.loads(
    subprocess.run(
        ["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE
    ).stdout
)

space_focused = [space for (space) in spaces if space["has-focus"]][0]["index"]

spaces_to_list = [
    space["index"] for (space) in spaces if has_visible_windows(space["index"])
] + [space_focused]

spaces_to_list = sorted(set(spaces_to_list))

spaces_to_list = map(find_color, spaces_to_list)

print("🖥️ " + " ".join(spaces_to_list) + " | ansi=true")
