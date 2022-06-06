vim.keymap.set('n', 's', '<Nop>')
vim.keymap.set('x', 's', '<Nop>')

-- Avoid conflict with targets.vim
vim.g.textobj_sandwich_no_default_key_mappings=1

local recipes = vim.fn["sandwich#get_recipes"]()

table.insert(recipes, {
    action = { "add" },
    buns = { "{ ", " }" },
    input = { "{" },
    kind = { "add", "replace" },
    match_syntax = 1,
    nesting = 1,
})

table.insert(recipes, {
    action = { "add" },
    buns = { "[ ", " ]" },
    input = { "[" },
    kind = { "add", "replace" },
    match_syntax = 1,
    nesting = 1,
})

table.insert(recipes, {
    action = { "add" },
    buns = { "( ", " )" },
    input = { "(" },
    kind = { "add", "replace" },
    match_syntax = 1,
    nesting = 1,
})

table.insert(recipes, {
    action = { "delete" },
    buns = { "{\\s*", "\\s*}" },
    input = { "{" },
    kind = { "delete", "replace", "textobj" },
    match_syntax = 1,
    nesting = 1,
    regex = 1,
})

table.insert(recipes, {
    action = { "delete" },
    buns = { "\\[\\s*", "\\s*\\]" },
    input = { "[" },
    kind = { "delete", "replace", "textobj" },
    match_syntax = 1,
    nesting = 1,
    regex = 1,
})

table.insert(recipes, {
    action = { "delete" },
    buns = { "(\\s*", "\\s*)" },
    input = { "(" },
    kind = { "delete", "replace", "textobj" },
    match_syntax = 1,
    nesting = 1,
    regex = 1,
})

vim.g["sandwich#recipes"] = recipes
