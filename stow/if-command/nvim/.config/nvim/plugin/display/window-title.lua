vim.o.title = true
vim.o.titlestring = require("utils").get_neovim_symbol()
    .. " [%{v:lua.require('utils').get_filename_homedir_shortened()}%( %M%)]"
