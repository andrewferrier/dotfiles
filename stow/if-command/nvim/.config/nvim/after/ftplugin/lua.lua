-- See https://www.reddit.com/r/neovim/comments/pl0p5v/comment/hc78cye/
vim.opt_local.path:append("," .. vim.fn.stdpath("config") .. "/**")
vim.opt_local.path:append("," .. vim.fn.stdpath("data") .. "/**")
vim.opt_local.suffixesadd:prepend(".lua")
vim.opt_local.suffixesadd:prepend("init.lua")

-- See https://www.reddit.com/r/neovim/comments/v3yv2x/comment/ib19q5j/
vim.bo.includeexpr = 'substitute(v:fname, "\\\\.", "/", "g")'

require("filetype.section").setup_navigation(
    "^\\w\\(nd$\\)\\@!",
    "^\\(}\\|end\\)"
)
