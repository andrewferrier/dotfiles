local M = {}

M.make_readonly = function()
    vim.bo.readonly = true
    vim.bo.syntax = ""
    vim.opt_local.concealcursor = "nc"
    vim.opt_local.conceallevel = 2
    vim.opt_local.list = false
    vim.opt_local.spell = false

    require("filetype.status_column").remove_signs()
    require("diagnostics").hide()
    require("gitsigns").detach()

    if vim.b.text_based_filetype then
        require("wrapping").soft_wrap_mode()
    end
end

return M
