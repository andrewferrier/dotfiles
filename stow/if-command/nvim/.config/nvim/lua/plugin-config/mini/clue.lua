local miniclue = require("mini.clue")

miniclue.setup({
    triggers = {
        -- Clues that come from mini.clue
        { mode = "i", keys = "<C-x>" },

        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        { mode = "n", keys = "<C-w>" },

        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- Other keys with already-existent clues
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "x", keys = "[" },
        { mode = "x", keys = "]" },

        { mode = "n", keys = "cv" },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers({ show_contents = true }),
        miniclue.gen_clues.windows({ submode_resize = true }),
        miniclue.gen_clues.z(),
    },
    window = {
        config = {
            width = "auto",
        },
    },
})
