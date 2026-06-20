# AGENTS.md

## Purpose

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).
`make` symlinks configs into `$HOME` and runs post-install configuration
scripts. The utility scripts documented in `README.md` are primarily those which
may be of external interest.

## Key structure

If making a change to this structure, you must update this documentation table.

| Path                                                       | Purpose                                                       |
| ---------------------------------------------------------- | ------------------------------------------------------------- |
| `stow/`                                                    | Config files, symlinked into `$HOME` by Stow                  |
| `stow/common/`                                             | Applies on every platform                                     |
| `stow/linux/`, `stow/macos/`, `stow/arch/`, `stow/debian/` | OS/distro-specific configs                                    |
| `stow/desktop/`, `stow/server/`                            | Machine-role configs                                          |
| `stow/full-install/`, `stow/simple-install/`               | Install-type configs                                          |
| `stow/if-command/`                                         | Configs stowed only when a given command exists               |
| `pre-stow/`                                                | Scripts run before stowing (common, linux, macos)             |
| `configure/`                                               | Scripts run after stowing for post-install setup              |
| `pkgs/`                                                    | Package installation per distro (arch, debian, macos, alpine) |
| `.bin/`                                                    | Internal helper scripts used by the Makefile                  |
| `common.sh`                                                | Shared shell helpers sourced by scripts in this repo          |

## Rules

- This repository requires Conventional Commits for every commit message for any
  contribution that an AI agent creates or suggests. Follow the standard
  conventional commit rules from
  <https://www.conventionalcommits.org/en/v1.0.0/> - if unsure, ask the user.

- For every contribution to this repository, run `pre-commit` on the relevant
  files before suggesting the change to ensure that the change is pre-commit
  compliant.
