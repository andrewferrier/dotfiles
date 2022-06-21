local hydra = require("hydra")

hydra({
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

vim.api.nvim_set_hl(0, "HydraBlue", { link = "GruvboxBlue" })
