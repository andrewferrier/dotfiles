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

-- Move to appropriate indent on 'i'. See
-- https://www.reddit.com/r/neovim/comments/12rqyl8/comment/jgvs6im/?utm_source=share&utm_medium=web2x&context=3
local move_to_indent = function()
    if #vim.fn.getline(".") == 0 then
        return [["_cc]]
    else
        return "i"
    end
end

vim.keymap.set("n", "i", move_to_indent, { expr = true })
