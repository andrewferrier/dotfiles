vim.opt.completeopt:remove("noinsert")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:append("preview") -- Doesn't reliably close

vim.opt.nrformats:append("unsigned")

if vim.fn.has("nvim-0.9.0") == 1 and not vim.fn.has('gui_vimr') then
    -- VimR presents as NeoVim 0.9 even though it's really 0.8
    vim.opt.diffopt:append("linematch:60")
end
