# Vim Config README

## Keybinding Cheat Sheet

### Normal Mode

    !{motion}<command> - filter {motion} through command line
    + - go to the beginning of the next line
    1z= - replace with first choice from spellcheck dictionary
    <number> Ctrl-A/X - add/decrement specific amount
    Ctrl-E/Y - scroll window without moving cursor
    Ctrl-W Ctrl-F - open the file under cursor in a split (similar to gf)
    Ctrl-W Ctrl-] - jump to definition in new window
    Ctrl-^ - Open last file
    Ctrl-i - "in" - opposite of Ctrl-o
    Ctrl-o - on opening vim, go immediately to last file edited
    H, M, L - go to top, middle, bottom of the screen
    Use uppercase registers to append
    X - delete the character before the cursor
    [buffer]do - pull hunk from numbered buffer
    [count]. - repeat edit [count] times
    [count]ch|j|k|l - Delete [count] characters in direction and start insert
    [count]i-<Esc>, [count]I-<Esc> - insert 10 dashes at cursor or beginning of line
    [count]r<char> - replace the next [count] characters with <char>
    ]i, [i - move by indents
    d'a - delete to mark "a"
    dV/xyz/-1 - delete linewise up to but not including line with pattern
    dm<space> - delete all marks
    g;, g, - jump backwards/forwards through changes
    g={motion} - evaluate
    gJ - Join lines w/o additional space, but include indent
    gM - move cursor to half-way along line
    gO - show file outline (e.g. for Man)
    gi - insert in last place I inserted
    gj, gk, g$, g0 - go up and down by screen lines, end and beginning by screen line (useful when wrapped)
    gp, gP - paste, but leave cursor after text
    gt - go to next tab
    m, - set next available mark
    mA - set an uppercase mark, for jumping across files
    q: - open command mode window
    qA - resume recording into macro A
    qaq:g/regex/y A - empty register 'a', then append each line matching regex to register 'a'
    sa{text object}? - add 'instant' leader and footer around text object
    v{motion}"{reg}P - replace with register/clipboard, and DON'T yank what's being replaced
    y{motion} :%s/<Ctrl-R>"/replacement/g - replace text object globally
    y{motion}, /<Ctrl-R>" - Search for yanked text
    z<CR> - put current line near top of the screen
    zM/R - close/open all folds

### Normal Mode (Markdown)

    sa{text object}l - add link with text as link text
    sa{text object}L - add link with text as URL

### Insert Mode

    Ctrl-A - insert last text inserted
    Ctrl-K ,. - insert …
    Ctrl-K Co - insert ©
    Ctrl-K DG - insert °
    Ctrl-K HT - insert <Tab>
    Ctrl-K OK - insert ✓
    Ctrl-K XX - insert ✗
    Ctrl-K oo - insert •
    Ctrl-O ^ - go to non-whitespace beginning of line
    Ctrl-R = - use expression register
    Ctrl-R Ctrl-R <register> - insert register literally
    Ctrl-T/D - indent/dedent
    Ctrl-U - wipe out line (like 'cc')
    Ctrl-W - delete word before cursor

### Visual Mode

    !figlet - Take lines and pass through figlet to create ASCII art
    g Ctrl-A Increment each line in visual selection by one more
    @q - repeat macro q for each line

### Command Mode

    %!<command> - capture output of [shell] command into current buffer
    %norm ... - run normal mode commands on every line
    %s/\v(pattern)/\U\1\e/ - convert to uppercase
    /\Vpattern/ - very nomagic (most chars literal; don't use regexes)
    /\vpattern/ - very magic (most chars non-literal)
    Cfilter <pattern> - filter quickfix list
    Ctrl-R Ctrl-w/a - insert the word/WORD under cursor
    Ctrl-W - backspace over word
    DiagnosticQFList - put all diagnostic items in a quickfix buffer
    EditQuery - edit treesitter query
    GitQFList - show all git hunks in a quickfix buffer
    Inspect - check treesitter/highlight items
    InspectTree - treesitter inspect
    Mkdir - create directory for current file
    args files/file.* | :argdo %s/pattern/replacement/g | :argdo update - search and replace across files
    cfdo %s/x/y/g | update - search and replace in quickfix list
    cquit - quit with an exit code
    g!/regex/d - delete all lines that don't match regex
    g/regex/norm gcc - comment out lines that match regex
    grep <pattern> - search and populate quickfix list (using Rg)
    let @/='text/with/lots/of/slashes' - define search pattern (then use n/N)
    w ++p - write and create parent dirs (0.9+ only)
    wn - write and move to next file in args list

### Lua Functions/Expressions

    vim.treesitter.query.edit() - treesitter query editor
    =<expression> - print expression

#### Based on a Visual Range

    '<,'>:norm . - apply previous change to all lines
    '<,'>!uniqall - filter out duplicate (non-consecutive) lines

### Text Object/Operator Pending Mode/Visual Mode Select

    ac (TeX) - command
    ae (TeX) - environment
    gc - comment
    gn/gN - next/previous search match
    i#/a# - section (markdown)
    iS/aS - subword
    ia/aa - function argument, excluding/including separator
    ii/ai - same or lower indent level/same or lower indent including blank lines
    ik/ak - key (LHS of expression)
    iv/av - value (RHS of expression)
    m - select area based on Treesitter

### FZF

    Ctrl-T - open file in new tab
    Tab - select file (then Alt-Q to open in Quickfix)

### Search Pattern

    \zs, \ze - indicate where match starts within pattern (useful for search and replace)

### VimTeX Filetype

    \ll - build file
    \lo - open PDF
    \lc - clean build directory

### Quickfix Window

    Replacer (command) - enter modifiable mode

## Links

*   [Advanced Search and Replace](https://gosukiwi.github.io/vim/2022/04/19/vim-advanced-search-and-replace.html)
*   [Available lowercase key pairs](https://gist.github.com/romainl/1f93db9dc976ba851bbb)
*   [Create text objects](https://thevaluable.dev/vim-create-text-objects/)
*   [Dot repeat/count/operator-pending](https://www.vikasraj.dev/blog/vim-dot-repeat)
*   [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
*   [History and effective use of Vim](https://begriffs.com/posts/2019-07-19-history-use-vim.html)
*   [Lua function parity against VimScript](https://github.com/neovim/neovim/issues/18393)
*   [NeoVim default mappings](https://docs.google.com/spreadsheets/d/1EJMLr_MPrYiO1TKJ2MjNkR-fA5Wgxa782-f0Wtdpz0w)
*   [Power of :g](https://vim.fandom.com/wiki/Power_of_g)
*   [Semantic highlighting](https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316)
*   [Using LibUV in Neovim](https://teukka.tech/vimloop.html)
*   [Vim galore](https://github.com/mhinz/vim-galore)
*   [Vim regexs](https://vi.stackexchange.com/a/2279/91)
*   [Vim's useful lists](https://codeinthehole.com/tips/vim-lists/)
*   [Why do we use `opt_local` and not vim.wo](https://github.com/neovim/neovim/issues/20271)
*   [bufdo/argdo/windo](https://jovica.org/posts/vim-edit-multiple-files/)
*   [lua reference manual](https://www.lua.org/manual/5.1/manual.html)
*   `help ex-cmd-index` — list ex commands - e.g., after g/pat/

## Principles

*   Custom operator bindings use `g<single letter>`.
*   "Swap" option keybindings are `yo<single letter>` following the pattern set by vim-unimpaired.

## TODO

*   Play with treesitter to highlight inside alias strings in bash/zsh; try <https://github.com/Dronakurl/injectme.nvim/tree/main>
*   Open a bug on NeoVim that 'confirm' when switching away from a dirty scratch buffer doesn't offer anything useful (see <https://github.com/ibhagwan/fzf-lua/issues/597#issuecomment-1373557215>)
*   0.10: Replace 'jobstart' with vim.system
*   0.10: Consider replacing gruvbox with retrobox
*   Look at switching to main branch for nvim-treesitter for nightly: <https://github.com/nvim-treesitter/nvim-treesitter/issues/4767>
*   Look at <https://github.com/zbirenbaum/copilot.lua>
*   Look at using 'winfixbuf': <https://github.com/neovim/neovim/issues/12517>

## Presentation Ideas

*   "<Leader> is wrong"
