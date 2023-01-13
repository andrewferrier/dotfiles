vim.opt_local.wrap = true
vim.opt_local.number = false
vim.opt_local.list = false

if vim.fn.has("nvim-0.9.0") == 1 then
    vim.opt_local.statuscolumn = ""
end
