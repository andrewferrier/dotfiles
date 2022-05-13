-- luacheck: globals vim

-- See https://www.reddit.com/r/neovim/comments/pl0p5v/comment/hc78cye/
vim.opt_local.suffixesadd:prepend(".lua")
vim.opt_local.suffixesadd:prepend("init.lua")
vim.opt.path:append("," .. vim.fn.stdpath("config") .. "/**")
vim.opt.path:append("," .. vim.fn.stdpath("data") .. "/**")

require("filetype.section").setup("^\\w\\(nd$\\)\\@!", "^\\(}\\|end\\)")
