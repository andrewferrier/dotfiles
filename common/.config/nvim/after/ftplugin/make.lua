-- luacheck: globals vim

vim.opt_local.foldmethod = 'indent'

require("filetype.section").setup("^\\S")
