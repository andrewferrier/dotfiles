local statefile = vim.fn.expand("~/.cache/day-night/state-terminal")

if
    vim.fn.filereadable(statefile)
    and vim.fn.index(vim.fn.readfile(statefile), "day") >= 0
then
    vim.opt.background = "light"
else
    vim.opt.background = "dark"
end

local palette = require("gruvbox.palette")

require("gruvbox").setup({
    contrast = "hard",
    overrides = {
        FidgetTitle = { link = "FidgetTask" },
        HydraBlue = { fg = palette.neutral_blue, bold = true },
        HydraHint = { link = "TabLineSel" },
        MatchParen = { bg = palette.neutral_orange, fg = palette.dark0 },
        QuickFixLine = { link = "IncSearch" },
        String = { italic = false },
        TermCursorNC = { bg = "#00FF00" },
    },
})

vim.cmd("colorscheme gruvbox")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYanked", {}),
    callback = function()
        require("vim.highlight").on_yank({ timeout = 200 })
    end,
})
