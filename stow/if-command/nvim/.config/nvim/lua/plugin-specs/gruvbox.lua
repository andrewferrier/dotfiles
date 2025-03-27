local STATEFILE = vim.fn.expand("~/.cache/day-night/state")

local update_background = function()
    if
        vim.fn.filereadable(STATEFILE)
        and vim.fn.index(vim.fn.readfile(STATEFILE), "day") >= 0
    then
        vim.opt.background = "light"
    else
        vim.opt.background = "dark"
    end
end

vim.uv.new_fs_event():start(STATEFILE, {
    watch_entry = true,
    stat = true,
}, function(err, _, _)
    if not err then
        vim.schedule(update_background)
    end
end)

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "ellisonleao/gruvbox.nvim",
    init = update_background,
    opts = {
        contrast = "hard",
        dim_inactive = true,
        transparent_mode = false,
        overrides = {
            DebugPrintLine = { link = "ErrorMsg" },
            DiagnosticUnnecessary = { link = "Whitespace" },
            OilInfo = { link = "NonText" },
            SignColumn = { link = "LineNr" },
            ["@lsp.mod.readonly"] = { bold = true },
        },
        italic = {
            strings = false,
        },
    },
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme("gruvbox")
    end,
}
