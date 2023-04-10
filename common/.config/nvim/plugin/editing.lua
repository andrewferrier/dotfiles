vim.opt.mousescroll = "ver:3,hor:1"

vim.opt.completeopt:remove("noinsert")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:append("preview") -- Doesn't reliably close

vim.opt.nrformats:append("unsigned")

vim.opt.diffopt:append("linematch:60")

vim.opt.exrc = true

vim.keymap.set(
    "n",
    "[<Space>",
    "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
    { desc = "Put empty line(s) above" }
)

vim.keymap.set(
    "n",
    "]<Space>",
    "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
    { desc = "Put empty line(s) below" }
)
