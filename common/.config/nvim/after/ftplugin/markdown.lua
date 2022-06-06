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

vim.fn["sandwich#util#addlocal"](recipes)

vim.cmd("iabbrev <buffer> zTODO <span style=\"color:red\">TODO:</span><Esc>F<i")
