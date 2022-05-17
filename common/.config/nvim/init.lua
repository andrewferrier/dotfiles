-- luacheck: globals vim

-- See ~/.config/nvim/filetype.lua for custom filetype overrides

-- Use exclusively filetype.lua file detection, see
-- https://gpanders.com/blog/whats-new-in-neovim-0-7/
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Based on
-- https://neovim.discourse.group/t/how-to-disable-builtin-plugins/787/5
local builtin_plugs = {
    "2html",
    "gzip",
    "remote_plugins",
    "tarPlugin",
    "zipPlugin",
}

for i = 1, #builtin_plugs do
    vim.g["loaded_" .. builtin_plugs[i]] = true
end
