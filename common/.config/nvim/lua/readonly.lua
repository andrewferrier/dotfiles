local M = {}

M.make_readonly = function()
    if not vim.b.effective_ro_loaded then
        vim.opt_local.spell = false
        vim.opt_local.list = false
        vim.opt_local.readonly = true

        require("diagnostics").hide_silent()
        require("gitsigns").detach()

        if vim.fn.exists("b:text_based_filetype") then
            vim.fn["vim_wrapping_softhard#SoftWrapMode"]()
        end

        vim.b.effective_ro_loaded = true
    end
end

return M
