-- luacheck: globals vim

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

vim.cmd(
    "highlight TermCursorNC guibg=#00ff00 guifg=#FFFFFF ctermbg=1 ctermfg=6"
)

vim.cmd("highlight link StatusLineSecondary SignColumn")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYanked", {}),
    pattern = "*",
    callback = function()
        require('vim.highlight').on_yank({timeout = 200})
    end
})
