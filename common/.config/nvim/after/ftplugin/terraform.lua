-- This is set to a multi-line comment by default, which I don't like
vim.opt_local.commentstring = "# %s"

require("filetype.section").setup("^data\\|resource", "^}$")
