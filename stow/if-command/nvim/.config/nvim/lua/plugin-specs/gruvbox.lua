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

return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        update_background()

        local overrides = {
            DiagnosticUnnecessary = { link = "Whitespace" },
            SignColumn = { link = "LineNr" },
            TermCursorNC = { link = "DiffChange" },
            OilInfo = { link = "NonText" },
            ["@lsp.mod.readonly"] = { bold = true },
        }

        require("gruvbox").setup({
            contrast = "hard",
            dim_inactive = true,
            overrides = overrides,
            ---@diagnostic disable-next-line: missing-fields
            italic = {
                strings = false,
                operators = false,
            },
        })

        vim.cmd.colorscheme("gruvbox")
    end,
}
