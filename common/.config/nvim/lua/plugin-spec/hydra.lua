return {
    "anuvyklack/hydra.nvim",
    config = function()
        local hydra = require("hydra")

        hydra({
            name = "Window resizing",
            mode = "n",
            body = "<C-W>",
            heads = {
                { "+", "<C-W>+" },
                { "-", "<C-W>-" },
                { ">", "<C-W>>" },
                { "<", "<C-W><" },

                { "<Esc>", nil, { exit = true } },
            },
        })
    end,
    keys = "<C-W>",
}
