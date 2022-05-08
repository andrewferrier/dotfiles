-- luacheck: globals vim

-- See https://www.reddit.com/r/neovim/comments/pl0p5v/comment/hc78cye/
vim.cmd("setlocal suffixesadd^=.lua")
vim.cmd("setlocal suffixesadd^=init.lua")
vim.opt.path:append("," .. vim.fn.stdpath("config") .. "/**")
vim.opt.path:append("," .. vim.fn.stdpath("data") .. "/**")

require("filetype.section").setup("^\\w\\(nd$\\)\\@!", "^\\(}\\|end\\)")
