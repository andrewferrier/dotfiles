vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.display:append("uhex")
vim.opt.equalalways = false
vim.opt.hidden = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15
vim.opt.smoothscroll = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.switchbuf = "useopen"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"

vim.opt.list = true
vim.opt.listchars = {
    tab = ">⋅",
    trail = "·",
    extends = "…",
    precedes = "…",
    nbsp = "␣",
}

vim.opt.messagesopt = "hit-enter,history:10000"

vim.pack.add({ "https://github.com/rachartier/tiny-glimmer.nvim" })
require("tiny-glimmer").setup({
    overwrite = {
        -- Search is too confusing, because the highlight we end up using
        -- isn't clear once the animation has disappeared
        search = { enabled = false },
        undo = { enabled = true },
        redo = { enabled = true },
    },
})
