local redraw_timer

local delayed_redraw = function()
    vim.schedule(vim.cmd.redrawstatus)
    redraw_timer = nil
end

local callback = function()
    if redraw_timer ~= nil then
        vim.fn.timer_stop(redraw_timer)
    end

    vim.schedule(vim.cmd.redrawstatus)
    redraw_timer = vim.fn.timer_start(750, delayed_redraw)
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspProgress" }, {
    pattern = "*",
    callback = callback,
})

vim.o.statusline = "%!v:lua.require('statusline').render()"
