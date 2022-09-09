local statefile = vim.fn.expand("~/.cache/day-night/state-terminal")

local palette = require("gruvbox.palette")

local overrides = {
    FidgetTitle = { link = "FidgetTask" },
    HydraBlue = { fg = palette.neutral_blue, bold = true },
    HydraHint = { link = "TabLineSel" },
    Operator = { italic = false },
    QuickFixLine = { link = "IncSearch" },
    String = { italic = false },
    TermCursorNC = { bg = "#00FF00" },
}

if vim.fn.has("nvim-0.8.0") == 1 then
    -- Workarounds for tint.nvim; see
    -- https://github.com/levouh/tint.nvim/issues/11
    overrides = vim.tbl_extend("keep", overrides, {
        NormalNC = { link = "Normal" },
        CurSearch = { reverse = true },
    })
end

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
    overrides = overrides,
})

vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "MatchParen", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYanked", {}),
    callback = function()
        require("vim.highlight").on_yank({ timeout = 200 })
    end,
})
