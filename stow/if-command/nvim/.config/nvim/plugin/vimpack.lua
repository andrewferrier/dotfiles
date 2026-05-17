local M = {}

if vim.fn.has("nvim-0.13") == 0 then
    vim.api.nvim_create_user_command("PackUpdateAndClean", function(_)
        vim.pack.update(nil)

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
end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function()
        vim.cmd.helptags("ALL")
    end,
})

return M
