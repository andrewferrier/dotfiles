local statefile = vim.fn.expand("~/.cache/day-night/state-terminal")

if
    vim.fn.filereadable(statefile)
    and vim.fn.index(vim.fn.readfile(statefile), "day") >= 0
then
    vim.opt.background = "light"
else
    vim.opt.background = "dark"
end

require("gruvbox").setup({
    contrast = "hard",
    overrides = {
        MatchParen = { bg = require("gruvbox.palette").faded_orange },
        QuickFixLine = { link = "IncSearch" },
        String = { italic = false },
        TermCursorNC = { bg = "#00FF00", fg = "#FFFFFF" },

        NotifyERRORBorder = { link = "Normal" },
        NotifyERRORIcon = { link = "DiagnosticError" },
        NotifyERRORTitle = { link = "Normal" },
        NotifyINFOBorder = { link = "Normal" },
        NotifyINFOIcon = { link = "Normal" },
        NotifyINFOTitle = { link = "Normal" },
        NotifyWARNBorder = { link = "Normal" },
        NotifyWARNIcon = { link = "DiagnosticWarn" },
        NotifyWARNTitle = { link = "Normal" },

        FidgetTitle = { link = "LineNr" },
        HydraBlue = { link = "GruvboxBlue" },
        StatusLineSecondary = { link = "SignColumn" },
    },
})

vim.cmd("colorscheme gruvbox")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYanked", {}),
    callback = function()
        require("vim.highlight").on_yank({ timeout = 200 })
    end,
})
