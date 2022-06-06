-- This is required because netrw normally provides this capability, but we've
-- disabled it here: ../init.lua

vim.keymap.set("n", "gx", function()
    local viewer = vim.env.HOME .. "/.local/bin/common/open-file"
    local url = vim.fn.expand("<cfile>")
    vim.fn.jobstart({ viewer, url }, { detach = true })
end)
