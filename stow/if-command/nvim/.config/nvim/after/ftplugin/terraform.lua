-- This is set to a multi-line comment by default, which I don't like
vim.bo.commentstring = "# %s"

require("filetype.section").setup("^data\\|resource", "^}$")

require("treesitter-terraform-doc").setup({})

vim.keymap.set("n", "K", vim.cmd.OpenDoc, { buffer = 0, unique = true })
