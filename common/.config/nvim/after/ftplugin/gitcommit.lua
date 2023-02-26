require("filetype.text").setup()

if require("large_file").is_large_file() then
    vim.opt_local.spell = false
end

vim.opt_local.number = false
vim.opt_local.relativenumber = false
