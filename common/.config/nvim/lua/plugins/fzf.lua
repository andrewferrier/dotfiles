vim.keymap.set("n", "cvh", function()
    vim.cmd("Helptags")
end, { silent = true })

vim.keymap.set("n", "cvl", function()
    vim.cmd("Rg")
end, { silent = true })

vim.keymap.set("i", "<C-X><C-F>", "<Plug>(fzf-complete-path)")

-- Supplement Maps from fzf.vim.
vim.api.nvim_create_user_command("MapsI", function()
    vim.fn["fzf#vim#maps"]("i", 0)
end, {})

vim.api.nvim_create_user_command("MapsO", function()
    vim.fn["fzf#vim#maps"]("o", 0)
end, {})

vim.api.nvim_create_user_command("MapsX", function()
    vim.fn["fzf#vim#maps"]("x", 0)
end, {})

vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }
