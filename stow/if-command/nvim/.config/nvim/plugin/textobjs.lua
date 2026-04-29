vim.pack.add({ "https://github.com/chrisgrieser/nvim-various-textobjs" })

require("various-textobjs").setup({
    textobjs = {
        indentation = {
            blanksAreDelimiter = false,
        },
    },
})

local map = function(lhs, rhs, description)
    vim.keymap.set(
        { "o", "x" },
        lhs,
        '<cmd>lua require("various-textobjs").' .. rhs .. "<CR>",
        { desc = description, unique = true }
    )
end

map("ii", 'indentation("inner", "inner")', "indentation not inc. blank lines")
map("ik", 'key("inner")', "'key'/lhs")
map("ak", 'key("outer")', "'key'/lhs inc. assignment")
map("iv", 'value("inner")', "'value'/rhs")
map("av", 'value("outer")', "'value'/rhs inc. terminator")
map("id", "diagnostic()", "diagnostic")
