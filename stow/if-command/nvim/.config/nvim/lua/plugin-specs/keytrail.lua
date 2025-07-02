-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "jfryy/keytrail.nvim",
    opts = {
        key_mapping = nil,
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        {
            "nvim-telescope/telescope.nvim",
            opts = function()
                return {
                    defaults = {
                        mappings = {
                            i = {
                                ["<esc>"] = require("telescope.actions").close,
                            },
                        },
                    },
                }
            end,
            lazy = true,
        },
    },
    keys = {
        {
            "gO",
            ":KeyTrailJump<CR>",
            mode = "n",
            ft = { "json", "yaml" },
            silent = true,
        },
    },
}
