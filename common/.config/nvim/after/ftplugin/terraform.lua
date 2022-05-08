-- luacheck: globals vim

-- This is set to a multi-line comment by default, which I don't like
vim.cmd("setlocal commentstring=#%s")

require("filetype.section").setup("^data\\|resource", "^}$")
