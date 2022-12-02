require("filetype.text").setup()

if require("large_file").is_large_file() then
    vim.opt_local.spell = false
end
