-- See ~/.config/nvim/plugins/filetype.lua for custom filetype overrides

-- Based on
-- https://neovim.discourse.group/t/how-to-disable-builtin-plugins/787/5
local builtin_plugs = {
    "2html",
    "gzip",
    "remote_plugins",
    "tarPlugin",
    "zipPlugin",

    -- These lines are needed to avoid opening directories from command line in
    -- netrw: https://github.com/elihunter173/dirbuf.nvim#notes
    "netrw",
    "netrwPlugin",
}

for i = 1, #builtin_plugs do
    vim.g["loaded_" .. builtin_plugs[i]] = true
end
