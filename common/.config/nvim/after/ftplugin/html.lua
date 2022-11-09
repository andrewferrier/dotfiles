vim.keymap.set("n", "<Leader>v", ":silent !open %:p<CR>", { buffer = true })

-- Only used for hugo templates
vim.g.go_gopls_enabled = 0
vim.cmd.packadd("vim-go")
