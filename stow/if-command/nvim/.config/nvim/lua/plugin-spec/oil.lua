return {
    "stevearc/oil.nvim",
    config = function()
        local opts = {
            skip_confirm_for_simple_edits = true,
            view_options = { show_hidden = true },
            keymaps = {
                ["<C-s>"] = "actions.select_split",
                ["<C-v>"] = "actions.select_vsplit",
            },
        }

        if not vim.fn.executable("trash-put") then
            opts.delete_to_trash = false
        end

        require("oil").setup(opts)

        vim.keymap.set(
            "n",
            "-",
            "<CMD>Oil<CR>",
            { desc = "Open parent directory", unique = true }
        )
    end,
    version = "*",
}
