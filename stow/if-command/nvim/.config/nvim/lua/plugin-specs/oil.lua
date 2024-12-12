return {
    "stevearc/oil.nvim",
    opts = function()
        local opts = {
            skip_confirm_for_simple_edits = true,
            watch_for_changes = true,
            keymaps = {
                ["<C-s>"] = "actions.select_split",
                -- Don't use Ctrl-V as it breaks block select
            },
            columns = {
                "icon",
                { "permissions", highlight = "OilInfo" },
                { "size", highlight = "OilInfo" },
                { "mtime", format = "%Y-%m-%d %H:%M", highlight = "OilInfo" },
            },
        }

        if require("oil.fs").is_mac or vim.fn.executable("trash-put") then
            opts.delete_to_trash = true
        end

        return opts
    end,
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
            unique = true,
        },
    },
    dependencies = { "echasnovski/mini.nvim" }, -- for mini.icons
    version = "*",
}
