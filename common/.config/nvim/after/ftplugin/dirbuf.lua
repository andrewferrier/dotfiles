vim.opt_local.listchars:remove("tab:>·")
vim.opt_local.listchars:append("tab:  ")

require("diagnostics").hide()

-- These keybindings are intentionally similar to fzf
vim.keymap.set("n", "<C-S>", function()
    require("dirbuf").enter("split")
end, { buffer = true })
vim.keymap.set("n", "<C-T>", function()
    require("dirbuf").enter("tabedit")
end, { buffer = true })
