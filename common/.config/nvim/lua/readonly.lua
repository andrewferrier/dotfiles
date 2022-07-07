local M = {}

M.make_readonly = function()
    if not vim.b.effective_ro_loaded then
        vim.opt_local.spell = false
        vim.opt_local.list = false
        vim.opt_local.readonly = true
        vim.opt_local.conceallevel = 2

        require("diagnostics").hide()
        require("gitsigns").detach()

        if vim.b.text_based_filetype then
            require("wrapping").soft_wrap_mode()
        end

        vim.b.effective_ro_loaded = true
    end
end

return M
