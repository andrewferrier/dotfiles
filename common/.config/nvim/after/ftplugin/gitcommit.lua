require("filetype.text").setup("hard")

if require("large_file").is_large_file() then
    vim.opt_local.spell = false
end
