vim.opt_local.cursorline = true

vim.opt_local.listchars:remove("tab:>·")
vim.opt_local.listchars:append("tab:  ")

require("diagnostics").hide_silent()

-- These keybindings are intentionally similar to fzf
vim.keymap.set("n", "<C-X>", function()
    require("dirbuf").enter("split")
end)
vim.keymap.set("n", "<C-T>", function()
    require("dirbuf").enter("tabedit")
end)
