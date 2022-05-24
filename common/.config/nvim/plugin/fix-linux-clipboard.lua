-- luacheck: globals vim

-- See https://github.com/neovim/neovim/issues/16503; clipboard does not seem to
-- work correctly robustly with xclip (first call to `:registers` always shows
-- an error. 'xclip' will be selected by default if it is installed, and other
-- apps do appear to need it.

if vim.fn.executable("xsel") == 1 then
    vim.g.clipboard = {
        name = "xsel",
        copy = {
            ["*"] = { "xsel", "--nodetach", "-i", "-p" },
            ["+"] = { "xsel", "--nodetach", "-i", "-b" },
        },
        paste = {
            ["*"] = { "xsel", "-o", "-p" },
            ["+"] = { "xsel", "-o", "-b" },
        },
        cache_enabled = 1,
    }
end
