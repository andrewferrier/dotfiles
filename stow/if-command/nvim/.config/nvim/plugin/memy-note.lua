local home = vim.fn.expand("~")
local memy_dir = home .. "/memy"
local hooks_file = memy_dir .. "/hooks/neovim.lua"

if vim.fn.isdirectory(memy_dir) == 1 then
    dofile(hooks_file)
else
    local output = vim.fn.system("memy hook neovim.lua")
    assert(loadstring(output))()
end
