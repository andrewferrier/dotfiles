require("filetype.section").setup("^#")
require("filetype.text").setup()

vim.cmd("packadd markdown-preview.nvim")

vim.cmd('iabbrev <buffer> zTODO <span style="color:red">TODO:</span><Esc>F<i')
