-- luacheck: globals vim

vim.cmd("setlocal foldmethod=indent")

require("filetype.section").setup("^\\S")
