-- luacheck: globals vim

-- This has to be done using vimscript for now as lua has a confusing bug in
-- setting options, and we want these to be buffer-local:
-- https://github.com/neovim/neovim/issues/14670#issuecomment-1015648668
vim.cmd("setlocal cursorline")

vim.cmd("setlocal listchars-=tab:>·")
vim.cmd("setlocal listchars+=tab:\\ \\ ")

require('diagnostics').hide_silent()

-- These keybindings are intentionally similar to fzf
vim.keymap.set("n", "<C-X>", function()
    require("dirbuf").enter("split")
end)
vim.keymap.set("n", "<C-T>", function()
    require("dirbuf").enter("tabedit")
end)
