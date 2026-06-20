# Coding conventions

This file lists general coding instructions and conventions, both general and
language-specific. Ignore any language-specific conventions not relevant to the
languages currently being worked with.

## General

- Never run `git commit`, `git push`, `git rebase`, or any other git write
  operations. Leave all git commits and history management to the user.

- Irrespective of any other commands below, don't change code unrelated to the
  core features or bugs being added just to conform to standards or be more
  idiomatic or 'correct'.

- Write code in the idiomatic style for the language or context.

- Use clear, meaningful names for functions, variables, etc. Avoid placeholders
  like `x`, `i`, or `foo` unless specifically requested.

- Only add comments when they provide useful insight not obvious from the code
  itself. Let the code explain itself whenever possible.

- Where it makes sense to do so, use ISO-8601 for dates/times.

- Where it makes sense to do so, store data using the XDG standard.

- If there is an AI instructions file in the repo (e.g. `AGENTS.md`, `CLAUDE.md`,
  `.github/copilot-instructions.md`, `CONVENTIONS.md`), review it and follow
  instructions in it.

- There are skeleton files for various file formats in
  `~/dotfiles/stow/if-command/nvim/.config/nvim/skeleton/`. Use those as general
  guidance for formatting or constructing new files as appropriate.

## Bash / Shell Script

- Where possible, try to follow conventions set by shellcheck. In particular,
  ensure that `[[]]` are always used in preference to `[]`.

- Use uppercase for variable names.

## Python

- Use the logging module and STDERR for non-trivial output.

- Use argparse for scripts with multiple or complex arguments.

- Add type annotations wherever practical.

- Keep docstrings minimal unless you know the class/function is intended for reuse.

- Wherever possible, use modern pathlib (Path) functions.

## LaTeX

- Always use A4 paper.

- When it makes sense to do so - when there are repeated complex elements -
  create custom commands to keep things DRY.

- Use `booktabs` for nicer tables unless there's a reason otherwise.

- By default, margins should be 2cm or less.

- If there are URLs, use `hyperref` for clickable URL links.

- For simple one-pagers, use `\pagenumbering{gobble}` to remove page numbers.

## Markdown

- Always run `mdformat` (or another tool if the repository appears to already
  use it) to format Markdown. In particular, tables should always be formatted
  correctly with whitespace whenever they are changed.
