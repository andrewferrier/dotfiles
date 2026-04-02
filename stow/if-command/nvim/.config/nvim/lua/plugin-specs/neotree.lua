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
    opts = {
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function(_)
                    vim.opt.hidden = true
                    vim.notify_once("'hidden' enabled", vim.log.levels.WARN)
                end,
            },
        },
    },
    lazy = false,
}
