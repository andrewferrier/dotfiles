local M = {}

vim.api.nvim_create_user_command("PackUpdate", function(_)
    vim.pack.update(nil)
end, {})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function()
        vim.cmd.helptags("ALL")
    end,
})

return M
