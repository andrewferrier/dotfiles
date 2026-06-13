local MEMY_DIR = vim.fn.expand("~/memy")

if vim.fn.executable("memy") == 0 and vim.fn.isdirectory(MEMY_DIR) == 0 then
    vim.notify(
        "memy is not installed; memy note-taking disabled",
        vim.log.levels.WARN
    )
    return
end
local HOOKS_FILE = MEMY_DIR .. "/hooks/neovim.lua"

if vim.fn.isdirectory(MEMY_DIR) == 1 then
    dofile(HOOKS_FILE)
else
    local output = vim.fn.system("memy hook neovim.lua")
    assert(loadstring(output))()
end
