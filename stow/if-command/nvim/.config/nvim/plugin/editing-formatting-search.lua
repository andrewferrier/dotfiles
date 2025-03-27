vim.opt.clipboard = "unnamed" -- On OSX, unnamed=unnamedplus, on Linux, autocutsel syncs them anyway
vim.opt.expandtab = true
vim.opt.formatoptions:append("l")
vim.opt.ignorecase = true
vim.opt.mousescroll = "ver:3,hor:1"
vim.opt.nrformats:append("unsigned")
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.textwidth = 80 -- Default for most languages: https://en.wikipedia.org/wiki/Characters_per_line#In_programming
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full"

vim.opt.completeopt:append("fuzzy")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:remove("noinsert")

-- see https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append("algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:append("vertical")

vim.cmd.iabbrev("zDATE", '<C-R>=strftime("%F")<CR>')
vim.cmd.iabbrev("zDATETIME", '<C-R>=strftime("%FT%H:%M:%S")<CR>')

-- Search only inside visual selection
vim.keymap.set("x", "/", "<Esc>/\\%V")
