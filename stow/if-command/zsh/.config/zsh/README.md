# zsh cheatsheet

(Insert mode)

- `<Ctrl-U>` to delete behind cursor
- `<Ctrl-K>` to delete ahead of cursor
- `<Ctrl-W>` to backspace by word.

- `**<tab>` to autocomplete from directory.
- `<Ctrl-N>` to run file manager (lf)
- `<Ctrl-Q>` to stack current command, run another one, then come back to the original.
- `<Ctrl-T>` to run tig
- `<Ctrl-V>` to run NeoVim
- `<Ctrl-X> <Ctrl-E>` to edit command line in editor.
- `NQDIR=/tmp/somedir nq` to add items to queue.
- `echo filename | entr sh -c "filename"` to watch and re-run
- `entr` to re-run commands when list of files changes.
- `findmnt --real` to show mounted devices
- `man-fzf` to search through man pages.
- `uniqall` to get non-consecutive unique lines from a stream.
- `vipe` to edit as part of a pipe.

- `foo | xsel -ib` to copy to clipboard
- `xsel -ob | bar` to copy from clipboard

<!-- vim: set nospell: -->
