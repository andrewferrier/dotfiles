-- luacheck: globals vim
require("filetype.text").setup("soft")

-- Borrowed from
-- https://github.com/wincent/wincent/blob/main/aspects/nvim/files/.config/nvim/after/ftplugin/mail.lua;
-- 'If you use long lines, mutt will automatically switch to quoted-printable
-- encoding. This will generally look better in most places that matter (eg.
-- Gmail), where hard-wrapped email looks terrible and format=flowed is not
-- supported.'
vim.opt_local.textwidth = 0
