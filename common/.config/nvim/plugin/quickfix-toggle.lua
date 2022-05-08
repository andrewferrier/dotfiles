-- luacheck: globals vim

vim.keymap.set("n", "yoq", function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        require('quickfix').close()
    else
        require('quickfix').open()
    end
end)
