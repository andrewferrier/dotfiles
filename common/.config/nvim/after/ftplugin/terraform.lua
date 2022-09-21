-- This is set to a multi-line comment by default, which I don't like
vim.bo.commentstring = "# %s"

require("filetype.section").setup("^data\\|resource", "^}$")
