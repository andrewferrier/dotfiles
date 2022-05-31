-- luacheck: globals vim

vim.api.nvim_create_user_command("Trash", function(opts)
    local file = vim.fn.fnamemodify(vim.fn.bufname(opts.args), ":p")
    vim.api.nvim_buf_delete(0, { force = opts.bang })
    vim.fn.system({ "trash", file })
    if vim.fn.bufloaded(file) == 0 and vim.v.shell_error > 0 then
        vim.notify(
            "Couldn't move " .. file .. " to trash.",
            vim.log.levels.ERROR
        )
    end
end, {
    bang = true,
})
