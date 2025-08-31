-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "antosha417/nvim-lsp-file-operations",
    },
    lazy = false,
}
