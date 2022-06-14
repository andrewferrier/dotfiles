# Vim Config README

## Keybinding Cheat Sheet

### Normal Mode

    !{motion}<command> - filter {motion} through command line
    + - go to the beginning of the next line
    1z= - replace with first choice from spellcheck dictionary
    <number> Ctrl-A/X - add/decrement specific amount
    =p, =P - Paste correcting indent (from vim-unimpaired)
    Ctrl-E/Y - scroll window without moving cursor
    Ctrl-W Ctrl-F - open the file under cursor in a split (similar to gf)
    Ctrl-^ - Open last file
    Ctrl-i - "in" - opposite of Ctrl-o
    Ctrl-o - on opening vim, go immediately to last file edited
    H, M, L - go to top, middle, bottom of the screen
    Mkdir - create directory for current file
    Use uppercase registers to append
    X - delete the character before the cursor
    [count]. - repeat edit [count] times
    [count]ch|j|k|l - Delete [count] characters in direction and start insert
    [count]i-<Esc>, [count]I-<Esc> - insert 10 dashes at cursor or beginning of line
    [count]r<char> - replace the next [count] characters with <char>
    ]e, [e - move line down or up
    cvg - Change directory interactively
    d'a - delete to mark "a"
    dV/xyz/-1 - delete linewise up to but not including line with pattern
    g;, g, - jump backwards/forwards through changes
    gJ - Join lines w/o additional space, but include indent
    gM - move cursor to half-way along line
    gO - show file outline (e.g. for Man)
    gi - insert in last place I inserted
    gj, gk, g$, g0 - go up and down by screen lines, end and beginning by screen line (useful when wrapped)
    gt - go to next tab
    gyc{style}{text object} - change case of text object as per ~/.config/nvim/lua/plugins/text_case.lua
    m; - toggle (including remove) a mark on a line
    mA - set an uppercase mark, for jumping across files
    q: - open command mode window
    qA - resume recording into macro A
    qaq:g/regex/y A - empty register 'a', then append each line matching regex to register 'a'
    sa{text object}i - add 'instant' leader and footer around text object
    sa{text object}tp.someclass - add a <p class="someclass"> around text object
    v{motion}"{reg}p - replace with register/clipboard, and DON'T yank what's being replaced
    y{motion} :%s/<Ctrl-R>"/replacement/g - replace text object globally
    y{motion}, /<Ctrl-R>" - Search for yanked text
    z<CR> - put current line near top of the screen
    zM/R - close/open all folds

### Normal Mode (Markdown)

    sa{text object}l - add link with text as link text
    sa{text object}L - add link with text as URL

### Insert Mode

    Ctrl-A - insert last text inserted
    Ctrl-K HT - insert <Tab>
    Ctrl-K OK - insert ✓
    Ctrl-K XX - insert ✗
    Ctrl-O ^ - go to non-whitespace beginning of line
    Ctrl-R = - use expression register
    Ctrl-R Ctrl-R <register> - insert register literally
    Ctrl-T/D - indent/dedent
    Ctrl-U - wipe out line (like 'cc')
    Ctrl-W - delete word before cursor

### Visual Mode

    !figlet - Take lines and pass through figlet to create ASCII art
    g Ctrl-A Increment each line in visual selection by one more
    m - select area based on Treesitter

### Command Mode

    %!<command> - capture output of [shell] command into current buffer
    %norm ... - run normal mode commands on every line
    %s/\v(pattern)/\U\1\e/ - convert to uppercase
    /\Vpattern/ - very nomagic (most chars literal; don't use regexes)
    /\vpattern/ - very magic (most chars non-literal)
    Capture <vimcommand> - capture output of vim command into a buffer
    Ctrl-R Ctrl-w/a - insert the word/WORD under cursor
    DiagnosticQFList - put all diagnostic items in a quickfix buffer
    GitQFList - show all git hunks in a quickfix buffer
    args files/file.* | :argdo %s/pattern/replacement/g | :argdo update - search and replace across files
    cfdo %s/x/y/g | update - search and replace in quickfix list
    g!/regex/d - delete all lines that don't match regex
    g/regex/norm gcc - comment out lines that match regex
    grep <pattern> - search and populate quickfix list (using Rg)
    let @/='text/with/lots/of/slashes' - define search pattern (then use n/N)
    wn - write and move to next file in args list

#### Based on a Visual Range

    '<,'>:norm . - apply previous change to all lines
    '<,'>!uniqall - filter out duplicate (non-consecutive) lines

### Text Object/Operator Pending Mode

    gc - comment
    gn/gN - next/previous search match
    i#/a# - section (markdown)
    ia/aa - function argument, excluding/including separator
    ii/ai - same or lower indent level/same or lower indent including blank lines
    m - select area based on Treesitter

### FZF

    Ctrl-T - open file in new tab

## Links

*   [Advanced Search and Replace](https://gosukiwi.github.io/vim/2022/04/19/vim-advanced-search-and-replace.html)
*   [Available lowercase key pairs](https://gist.github.com/romainl/1f93db9dc976ba851bbb)
*   [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
*   [History and effective use of Vim](https://begriffs.com/posts/2019-07-19-history-use-vim.html)
*   [Power of :g](https://vim.fandom.com/wiki/Power_of_g)
*   [Using LibUV in Neovim](https://teukka.tech/vimloop.html)
*   [Vim galore](https://github.com/mhinz/vim-galore)
*   [Vim regexs](https://vi.stackexchange.com/a/2279/91)
*   [Vim's useful lists](https://codeinthehole.com/tips/vim-lists/)
*   [bufdo/argdo/windo](https://jovica.org/posts/vim-edit-multiple-files/)
*   `help ex-cmd-index` — list ex commands - e.g., after g/pat/

## Principles

*   Custom operator bindings use either `g<single letter>` or `gy<single letter>`.
*   "Swap" option keybindings are `yo<single letter>` following the pattern set by vim-unimpaired.

## TODO

*   Fix chewing up CPU when editing a large gitcommit file
*   Add support for Ctrl-W I, open definition in another window
*   Show LSP progress/loading (important for sumneko) - maybe use <https://github.com/nvim-lua/lsp-status.nvim>?
