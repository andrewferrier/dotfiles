local redraw_timer

local redraw_status = function()
    if redraw_timer ~= nil then
        vim.fn.timer_stop(redraw_timer)
        redraw_timer = nil
    end

    vim.schedule(vim.cmd.redrawstatus)
    redraw_timer = vim.fn.timer_start(750, function()
        vim.schedule(vim.cmd.redrawstatus)
        redraw_timer = nil
    end)
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspProgress" }, {
    pattern = "*",
    callback = redraw_status,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GitSignsUpdate",
    callback = redraw_status,
})

vim.opt.showcmdloc = "statusline"
vim.opt.statusline = "%!v:lua.require('statusline').render()"
