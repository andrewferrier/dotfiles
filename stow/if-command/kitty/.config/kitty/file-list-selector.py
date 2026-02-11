#!/usr/bin/env python

import argparse
import os
import subprocess

from kitty.boss import Boss  # ty:ignore[unresolved-import]


def main(args: list[str]) -> str:
    parser = argparse.ArgumentParser()

    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--files",
        action="store_true",
    )
    group.add_argument(
        "--dirs",
        action="store_true",
    )
    group.add_argument(
        "--maildirs",
        action="store_true",
    )
    parsed_args = parser.parse_args(args[1:])

    file_list_cmd: list[str] = ["file-list", "-s"]
    if parsed_args.files:
        file_list_cmd.append("-f")
    elif parsed_args.dirs:
        file_list_cmd.append("-d")
    elif parsed_args.maildirs:
        file_list_cmd.append("-d")
        file_list_cmd.append("-i")
        file_list_cmd.append("emails$")

    env = os.environ.copy()
    env["FZF_TMUX_HEIGHT"] = "100%"
    result = subprocess.run(  # noqa: S603
        file_list_cmd,
        capture_output=True,
        text=True,
        check=True,
        env=env,
    )

    return result.stdout.strip()


def handle_result(
    _args: list[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        w.paste_text(answer)
