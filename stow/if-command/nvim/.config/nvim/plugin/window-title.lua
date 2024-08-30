function _G.Titlestring_Filename()
    return vim.fn.pathshorten(require("utils").get_filename_homedir())
end

vim.o.title = true
vim.o.titlestring = require("utils").get_neovim_symbol()
    .. " [%{v:lua.Titlestring_Filename()}%( %M%)]"
