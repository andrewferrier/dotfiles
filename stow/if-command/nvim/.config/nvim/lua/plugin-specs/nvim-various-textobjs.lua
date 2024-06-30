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
        map("ik", 'key("inner")', "'key'/lhs")
        map("ak", 'key("outer")', "'key'/lhs inc. assignment")
        map("iv", 'value("inner")', "'value'/rhs")
        map("av", 'value("outer")', "'value'/rhs inc. terminator")
        map("id", "diagnostic()", "diagnostic")
    end,
    event = "BufEnter",
}
