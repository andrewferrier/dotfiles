-- luacheck: globals vim

vim.cmd("setlocal cursorcolumn")

require("filetype.section").setup("^\\S")
