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

event:start(STATEFILE, {
    watch_entry = true,
    stat = true,
}, function(err, _, _)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
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
            ["@lsp.mod.readonly"] = { bold = true },
        }

        require("gruvbox").setup({
            contrast = "hard",
            dim_inactive = true,
            overrides = overrides,
            italic = {
                strings = false,
                operators = false,
            },
        })

        vim.cmd.colorscheme("gruvbox")
    end,
}
