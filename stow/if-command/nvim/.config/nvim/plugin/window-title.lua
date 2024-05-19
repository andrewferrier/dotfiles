function _G.Titlestring_Filename()
    return vim.fn.pathshorten(require("utils").get_filename_homedir())
end

vim.o.title = true
vim.o.titlestring = " [%{v:lua.Titlestring_Filename()}%( %M%)]"
