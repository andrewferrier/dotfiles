vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.hidden = false
vim.opt.scrolloff = 5
vim.opt.showmode = false
vim.opt.sidescrolloff = 15
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:…,precedes:…,nbsp:␣"

if vim.fn.has("nvim-0.11.0") == 1 then
    vim.opt.messagesopt = "hit-enter,history:10000"
end
