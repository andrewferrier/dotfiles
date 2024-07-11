local M = {}

M.make_readonly = function()
    vim.bo.readonly = true
    vim.opt_local.concealcursor = "nc"
    vim.opt_local.conceallevel = 2
    vim.opt_local.list = false
    vim.opt_local.spell = false
    vim.opt_local.signcolumn = "no"

    require("gitsigns").detach()

    vim.diagnostic.enable(false, { bufnr = 0 })

    if vim.b.text_based_filetype then
        require("wrapping").soft_wrap_mode()
    end
end

return M
