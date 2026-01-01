# Coding conventions

This file lists general conventions and specific language conventions.
Ignore any language-specific conventions which are not relevant to the
languages currently being worked with.

## General

- Write code in the idiomatic style for the language or context.

- Use clear, meaningful names for functions, variables, etc. Avoid placeholders
  like `x`, `i`, or `foo` unless specifically requested.

- Only add comments when they provide useful insight not obvious from the code
  itself. Let the code explain itself whenever possible.

- Where it makes sense to do so, use ISO-8601 for dates/times.

- Where it makes sense to do so, store data using the XDG standard.

## Python

- Use the logging module and STDERR for non-trivial output.

- Use argparse for scripts with multiple or complex arguments.

- Add type annotations wherever practical.

- Keep docstrings minimal unless you know the class/function is intended for reuse.
