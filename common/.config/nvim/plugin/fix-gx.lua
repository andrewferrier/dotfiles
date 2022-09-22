-- This is required because netrw normally provides this capability, but we've
-- disabled it here: ../init.lua

local VIEWER = vim.env.HOME .. "/.local/bin/common/open-file"

vim.keymap.set("n", "gx", function()
    local url = vim.fn.expand("<cfile>")
    vim.fn.jobstart({ VIEWER, url }, { detach = true, on_stderr = require("utils").job_stderr })
end)

vim.keymap.set("x", "gx", function()
    local url = require("utils").visual_selection_range()
    vim.fn.jobstart({ VIEWER, url }, { detach = true, on_stderr = require("utils").job_stderr })
end)
