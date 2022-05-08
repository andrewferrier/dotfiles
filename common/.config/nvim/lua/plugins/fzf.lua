-- luacheck: globals vim
vim.keymap.set("n", "cvh", ":Helptags<CR>", { silent = true })
vim.keymap.set("n", "cvl", ":Rg<CR>", { silent = true })

vim.keymap.set("i", "<C-X><C-F>", "<Plug>(fzf-complete-path)")

-- Supplement Maps from fzf.vim.
vim.api.nvim_create_user_command("MapsI", ":call fzf#vim#maps('i', 0)", {})
vim.api.nvim_create_user_command("MapsO", ":call fzf#vim#maps('o', 0)", {})
vim.api.nvim_create_user_command("MapsX", ":call fzf#vim#maps('x', 0)", {})

vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }
