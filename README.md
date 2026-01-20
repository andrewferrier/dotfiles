# Andrew Ferrier's dotfiles

This is my [dotfiles](https://dotfiles.io/) collection. Most of it's not intended for direct public consumption, although you're welcome (subject to the [the license](LICENSE)) to use whatever you find in here. However, I've also realized over time that there are a few utility scripts that I build for myself, that are stored in this repo and that might be useful to others, but don't have quite the polish and documentation and don't necessarily justify the complexity of their own GitHub repo. So, for your convenience, they are listed here. These are provided as-is, with minimal documentation except in some cases a `--help` argument, under [this license](LICENSE).

* [ical-archive](stow/common/.local/bin/common-dotfiles/ical-archive) - From a directory of `.ics` [iCal](https://en.wikipedia.org/wiki/ICalendar) files, archive the ones older than a certain number of days old into another directory.

* [ical-summary](stow/common/.local/bin/common-dotfiles/ical-summary) - From a directory of `.ics` [iCal](https://en.wikipedia.org/wiki/ICalendar) files, provides a summary of events.

* [linkding-clean](stow/common/.local/bin/common-dotfiles/linkding-clean) - Cleans up [Linkding](https://github.com/sissbruecker/linkding) bookmarks.

* [maildir-archive](stow/common/.local/bin/common-dotfiles/maildir-archive) - Archives old emails in a [Maildir](https://en.wikipedia.org/wiki/Maildir)-formatted mailbox.

* [maildir-spamfilter](stow/common/.local/bin/common-dotfiles/maildir-spamfilter) - Filters spam from a [Maildir](https://en.wikipedia.org/wiki/Maildir)-formatted mailbox.

* [todo-fzf](stow/common/.local/bin/common-dotfiles/todo-fzf) - Interactively select and manage [todoman](https://github.com/pimutils/todoman) items using [fzf](https://github.com/junegunn/fzf).

* [todo-fzf-formatter](stow/common/.local/bin/common-dotfiles/todo-fzf-formatter) - A helper script to format output for `todo-fzf`.

* [todo-trash-item](stow/common/.local/bin/common-dotfiles/todo-trash-item) - Another helper script, moves a specific [todoman](https://github.com/pimutils/todoman) item to a trash directory.

* [webcal-to-ics](stow/common/.local/bin/common-dotfiles/webcal-to-ics) - Converts a Webcal URL into a local `.ics` [iCal](https://en.wikipedia.org/wiki/ICalendar) file.
