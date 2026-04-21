local STATEFILE = vim.fn.expand("~/.cache/day-night/state")

local update_background = function()
    if
        vim.fn.filereadable(STATEFILE)
        and vim.fn.index(vim.fn.readfile(STATEFILE), "day") >= 0
    then
        vim.opt.background = "light"
    else
        vim.opt.background = "dark"
    end
end

vim.uv.new_fs_event():start(STATEFILE, {
    watch_entry = true,
    stat = true,
}, function(err, _, _)
    if not err then
        vim.schedule(update_background)
    end
end)

update_background()
