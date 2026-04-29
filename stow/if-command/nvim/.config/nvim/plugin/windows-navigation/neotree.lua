vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ "https://github.com/antosha417/nvim-lsp-file-operations" })
vim.pack.add({
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = "v3.x",
    },
}, { load = true })

require("neo-tree").setup({
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function(_)
                vim.opt.hidden = true
                vim.notify_once("'hidden' enabled", vim.log.levels.WARN)
            end,
        },
    },
    filesystem = {
        hijack_netrw_behavior = "disabled",
    },
})
