-- luacheck: globals vim

vim.opt.breakindent = true
vim.opt.equalalways = false
vim.opt.hidden = false -- https://github.com/neovim/neovim/pull/15410
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Fix https://github.com/neovim/neovim/issues/12288#issuecomment-626276240; I
-- also find it interesting to see the file summary when opening it.
vim.opt.shortmess:remove("F")
vim.opt.shortmess:append("c")

-- numbers and signs in the same column
vim.opt.signcolumn = "number"
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.foldlevel = 99

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:▷,precedes:◁,nbsp:␣"
