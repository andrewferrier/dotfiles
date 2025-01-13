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

---@diagnostic disable-next-line: undefined-field
local event = vim.uv.new_fs_event()

---@diagnostic disable-next-line: need-check-nil
event:start(STATEFILE, {
    watch_entry = true,
    stat = true,
}, function(err, _, _)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
        ---@diagnostic disable-next-line: need-check-nil
        event:stop()
    end

    vim.schedule(update_background)
end)

local opts_func = function()
    local opts = {
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
    }

    if vim.fn.has("nvim-0.11.0") == 0 then
        opts.overrides.TermCursorNC = { link = "DiffChange" }
    end

    return opts
end

return {
    "ellisonleao/gruvbox.nvim",
    init = update_background,
    opts = opts_func,
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme("gruvbox")
    end,
}
