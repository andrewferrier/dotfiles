local map = function(lhs, rhs, description)
    return {
        lhs,
        '<cmd>lua require("various-textobjs").' .. rhs .. "<CR>",
        mode = { "o", "x" },
        desc = description,
        unique = true,
    }
end

return {
    "chrisgrieser/nvim-various-textobjs",
    opts = {
        textobjs = {
            indentation = {
                blanksAreDelimiter = false,
            },
        },
    },
    keys = {
        map(
            "ii",
            'indentation("inner", "inner")',
            "indentation not inc. blank lines"
        ),
        map("ik", 'key("inner")', "'key'/lhs"),
        map("ak", 'key("outer")', "'key'/lhs inc. assignment"),
        map("iv", 'value("inner")', "'value'/rhs"),
        map("av", 'value("outer")', "'value'/rhs inc. terminator"),
        map("id", "diagnostic()", "diagnostic"),
    },
}
