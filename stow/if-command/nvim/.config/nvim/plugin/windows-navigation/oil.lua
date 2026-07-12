vim.pack.add({
    {
        src = "https://github.com/stevearc/oil.nvim",
        version = vim.version.range("*"),
    },
})
vim.pack.add({
    {
        src = "https://github.com/echasnovski/mini.nvim",
        version = vim.version.range("*"),
    },
})

---@type oil.SetupOpts
local opts = {
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    keymaps = {
        ["<C-s>"] = "actions.select_split",
        -- Don't use Ctrl-V as it breaks block select
    },
    -- selene: allow(mixed_table)
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

require("oil").setup(opts)

vim.keymap.set("n", "-", function()
    require("oil").open()
end, { desc = "Open parent directory", unique = true })
