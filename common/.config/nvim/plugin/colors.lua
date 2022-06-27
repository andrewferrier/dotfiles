vim.g.gruvbox_contrast_light = "hard"
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_italic = 1

local statefile = vim.fn.expand("~/.cache/day-night/state-terminal")

if
    vim.fn.filereadable(statefile)
    and vim.fn.index(vim.fn.readfile(statefile), "day") >= 0
then
    vim.opt.background = "light"
else
    vim.opt.background = "dark"
end

vim.cmd("colorscheme gruvbox")

vim.api.nvim_set_hl(0, "NotifyERRORBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyINFOBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyWARNBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { link = "Normal" })

vim.api.nvim_set_hl(0, "FidgetTitle", { link = "LineNr" })
vim.api.nvim_set_hl(0, "QuickFixLine", { link = "CurSearch" })
vim.api.nvim_set_hl(0, "StatusLineSecondary", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "TermCursorNC", { bg = "#00FF00", fg = "#FFFFFF" })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYanked", {}),
    callback = function()
        require("vim.highlight").on_yank({ timeout = 200 })
    end,
})
