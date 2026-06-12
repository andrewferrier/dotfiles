# AGENTS.md

This repository requires Conventional Commits for every commit message that
GitHub Copilot creates or suggests.

## Commit message rules

- Always use the format `<type>(<optional-scope>): <imperative summary>`.
- Keep the summary concise, lower-case, and without a trailing period.
- Use only these commit types so messages stay compatible with the repository's
  gitlint configuration:
  - `fix`
  - `feat`
  - `chore`
  - `docs`
  - `style`
  - `refactor`
  - `perf`
  - `test`
  - `revert`
  - `ci`
  - `build`
  - `security`
- Use `docs` for documentation-only changes.
- If a scope is helpful, keep it short and specific.
- When choosing between multiple types, prefer the narrowest accurate type.

## When this applies

- Follow these rules for every generated commit message, including commit
  messages used in progress reporting tools.
