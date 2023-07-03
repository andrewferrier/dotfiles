vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.hidden = false
vim.opt.scrolloff = 5
vim.opt.showmode = false
vim.opt.sidescrolloff = 15
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true

if vim.fn.has("nvim-0.10.0") == 1 then
    vim.opt.smoothscroll = true
end

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:▷,precedes:◁,nbsp:␣"
