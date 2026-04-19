local redraw_timer

local delayed_redraw = function()
    vim.schedule(vim.cmd.redrawstatus)
    redraw_timer = nil
end

local redraw_status = function()
    if redraw_timer ~= nil then
        vim.fn.timer_stop(redraw_timer)
    end

    vim.schedule(vim.cmd.redrawstatus)
    redraw_timer = vim.fn.timer_start(750, delayed_redraw)
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspProgress" }, {
    pattern = "*",
    callback = redraw_status,
})

vim.api.nvim_create_autocmd("Progress", {
    pattern = { "term" },
    callback = function(ev)
        print(string.format("Progress event: %s", vim.inspect(ev)))
        redraw_status()
    end,
})

vim.opt.showcmdloc = "statusline"
vim.opt.statusline = "%!v:lua.require('statusline').render()"
