-- This is required because netrw normally provides this capability, but we've
-- disabled it here: ../init.lua

local open_url = function(url)
    vim.fn.jobstart(
        { vim.env.HOME .. "/.local/bin/common/open-file", url },
        { detach = true, on_stderr = require("utils").job_stderr }
    )
end

vim.keymap.set("n", "gx", function()
    require("various-textobjs").url()

    if vim.fn.mode():find("v") then
        local url = require("utils").visual_selection_range()
        open_url(url)
        vim.fn.feedkeys("v")
    else
        vim.notify("Cannot find URL.", vim.log.levels.WARN)
    end
end, { desc = "Smart URL Opener" })

vim.keymap.set("x", "gx", function()
    local url = require("utils").visual_selection_range()
    open_url(url)
end)
