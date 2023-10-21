return {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
        local map = function(lhs, rhs, description)
            vim.keymap.set(
                { "o", "x" },
                lhs,
                '<cmd>lua require("various-textobjs").' .. rhs .. "<CR>",
                { desc = description, unique = true }
            )
        end

        map(
            "ii",
            'indentation("inner", "inner", "noBlanks")',
            "indentation not inc. blank lines"
        )
        map(
            "ai",
            'indentation("inner", "inner")',
            "indentation inc. blank lines"
        )
        map("ak", 'key("inner")', "'key'/lhs inc. assignment")
        map("ik", 'key("outer")', "'key'/lhs")
        map("av", 'value("inner")', "'value'/rhs inc. terminator")
        map("iv", 'value("outer")', "'value'/rhs")
        map("aS", 'subword("inner")', "SubWord")
        map("iS", 'subword("outer")', "SubWord")
        map("id", "diagnostic()", "diagnostic")
    end,
    event = "BufEnter",
}
