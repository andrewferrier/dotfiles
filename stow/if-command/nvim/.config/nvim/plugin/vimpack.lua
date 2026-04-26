local M = {}

vim.api.nvim_create_user_command("PackUpdate", function(_)
    vim.pack.update(nil)
end, {})

vim.api.nvim_create_user_command("PackClean", function(_)
    local inactive_names = vim.tbl_map(
        function(plugin)
            return plugin.spec.name
        end,
        vim.tbl_filter(function(plugin)
            return not plugin.active
        end, vim.pack.get())
    )

    vim.pack.del(inactive_names)
end, {})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function()
        vim.cmd.helptags("ALL")
    end,
})

return M
