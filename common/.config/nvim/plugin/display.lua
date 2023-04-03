vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.hidden = false -- https://github.com/neovim/neovim/pull/15410
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15
vim.opt.splitbelow = true
vim.opt.splitright = true

if vim.fn.has("nvim-0.9.0") == 1 then
    vim.opt.splitkeep = "screen"

    vim.opt.shortmess:append("C") -- Reduce command line messages
end

vim.opt.shortmess:append("S") -- Because we have our own search counter

-- Fix https://github.com/neovim/neovim/issues/12288#issuecomment-626276240; I
-- also find it interesting to see the file summary when opening it.
vim.opt.shortmess:append("c")

vim.opt.list = true
vim.opt.listchars = "tab:>⋅,trail:·,extends:▷,precedes:◁,nbsp:␣"
