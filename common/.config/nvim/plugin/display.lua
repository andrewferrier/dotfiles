vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.scrolloff = 5
vim.opt.shortmess:append("c")
vim.opt.showmode = false
vim.opt.sidescrolloff = 15
vim.opt.splitbelow = true
vim.opt.splitright = true

if vim.fn.has("nvim-0.9.0") == 1 and not vim.fn.has('gui_vimr') then
    -- VimR presents as NeoVim 0.9 even though it's really 0.8
    vim.opt.splitkeep = "screen"
end

-- numbers and signs in the same column
vim.opt.signcolumn = "number"
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.foldlevel = 99

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:▷,precedes:◁,nbsp:␣"
