vim.opt.clipboard = "unnamed" -- On OSX, unnamed=unnamedplus, on Linux, autocutsel syncs them anyway
vim.opt.completeopt:append("preview") -- Doesn't reliably close
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:remove("noinsert")
vim.opt.diffopt:append("linematch:60")
vim.opt.expandtab = true
vim.opt.formatoptions:append("l")
vim.opt.ignorecase = true
vim.opt.mousescroll = "ver:3,hor:1"
vim.opt.nrformats:append("unsigned")
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.textwidth = 80 -- This is the default for many/most languages: https://en.wikipedia.org/wiki/Characters_per_line#In_programming
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full"

-- see https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("vertical")

vim.cmd('iabbrev zDATE <C-R>=strftime("%F")<CR>')
vim.cmd('iabbrev zDATETIME <C-R>=strftime("%FT%H:%M:%S")<CR>')

-- This generic behaviour for rename will be overwritten by treesitter.lua where
-- supported. Don't use 'cxr' in visual mode as it will block 'c'.
vim.keymap.set(
    "n",
    "cxr",
    ":%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>",
    { desc = "Replace word" }
)

vim.keymap.set(
    "n",
    "[<Space>",
    "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
    { desc = "Put empty line(s) above" }
)

vim.keymap.set(
    "n",
    "]<Space>",
    "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
    { desc = "Put empty line(s) below" }
)
