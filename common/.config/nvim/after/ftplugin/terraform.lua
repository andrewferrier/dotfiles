-- This is set to a multi-line comment by default, which I don't like
vim.bo.commentstring = "# %s"

require("filetype.section").setup("^data\\|resource", "^}$")

vim.keymap.set("n", "K", function()
    vim.cmd.OpenDoc()
end, { buffer = 0 })
