vim.opt.completeopt:remove("noinsert")
vim.opt.completeopt:remove("menuone")
vim.opt.completeopt:append("preview") -- Doesn't reliably close

vim.opt.nrformats:append("unsigned")

if vim.fn.has("nvim-0.9.0") == 1 then
    vim.opt.diffopt:append("linematch:60")
end

vim.opt.exrc = true
