-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "jfryy/keytrail.nvim",
    opts = {
        key_mapping = nil,
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
