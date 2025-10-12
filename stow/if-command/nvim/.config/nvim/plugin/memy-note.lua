local MEMY_DIR = vim.fn.expand("~/memy")
local HOOKS_FILE = MEMY_DIR .. "/hooks/neovim.lua"

if vim.fn.isdirectory(MEMY_DIR) == 1 then
    dofile(HOOKS_FILE)
else
    local output = vim.fn.system("memy hook neovim.lua")
    assert(loadstring(output))()
end
