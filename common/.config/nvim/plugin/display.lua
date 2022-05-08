-- luacheck: globals vim

-- numbers and signs in the same column
vim.opt.signcolumn = "number"
vim.opt.relativenumber = true
vim.opt.number = true

-- https://github.com/neovim/neovim/pull/15410
vim.opt.hidden = false
