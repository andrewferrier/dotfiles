-- luacheck: globals vim
require("filetype.text").setup("hard")

if require("large_file").is_large_file() then
    vim.cmd('setlocal nospell')
end
