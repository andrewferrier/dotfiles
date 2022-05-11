-- luacheck: globals vim

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
