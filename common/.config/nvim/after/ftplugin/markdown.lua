-- luacheck: globals vim

-- This is adapted from
-- ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/lua/nvim-treesitter/info.lua
if #vim.api.nvim_get_runtime_file("parser/markdown.so", false) <= 0 then
    vim.opt_local.foldmethod = "manual"
end

require("filetype.section").setup("^#")
require("filetype.text").setup()

vim.cmd("packadd markdown-preview.nvim")

local recipes = {}

table.insert(recipes, {
    action = { "add" },
    buns = { "[", "]()" },
    input = { "l" },
    kind = { "add", "replace" },
    match_syntax = 1,
})

table.insert(recipes, {
    action = { "add" },
    buns = { "[](", ")" },
    input = { "L" },
    kind = { "add", "replace" },
    match_syntax = 1,
})

vim.fn['sandwich#util#addlocal'](recipes)
