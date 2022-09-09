vim.opt_local.listchars:remove("tab:>·")
vim.opt_local.listchars:append("tab:  ")

-- No limit: https://golang.org/doc/effective_go#formatting
vim.bo.textwidth = 0
