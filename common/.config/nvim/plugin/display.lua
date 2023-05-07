vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.hidden = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true

if vim.fn.has("nvim-0.10.0") == 1 then
    vim.opt.smoothscroll = true
end

-- Reduce command line messages since we can't see them properly anyway with
-- cmdheight = 0
vim.opt.shortmess:append("C")
vim.opt.shortmess:append("S") -- We have our own search counter
vim.opt.shortmess:append("c")
vim.opt.shortmess:append("s")

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:▷,precedes:◁,nbsp:␣"
