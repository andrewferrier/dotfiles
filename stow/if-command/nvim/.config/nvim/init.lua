vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local fs_stat
if vim.fn.has("nvim-0.10.0") == 1 then
    fs_stat = vim.uv.fs_stat
else
    -- Deprecated in 0.10+
    fs_stat = vim.loop.fs_stat
end

if not fs_stat(lazypath) then
    vim.notify("Installing lazy...")

    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        print('ERROR: ' .. result)
    end
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugin-spec", {
    lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
    install = {
        colorscheme = { "gruvbox" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html",
                "gzip",
                "remote_plugins",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",

                -- These lines are needed to avoid opening directories from command line in
                -- netrw: https://github.com/elihunter173/dirbuf.nvim#notes
                "netrw",
                "netrwPlugin",
            },
            paths = { vim.fn.stdpath("data") .. "/skeleton" },
        },
    },
    change_detection = {
        enabled = false,
    },
    ui = {
        border = "single",
        icons = {
            cmd = "(cmd)",
            config = "(cfg)",
            event = "(evnt)",
            ft = "(ft)",
            init = "(init)",
            import = "(imprt) ",
            keys = "(kys)",
            lazy = "(lzy) ",
            loaded = "(ldd)",
            not_loaded = "(nt ldd)",
            plugin = "(plgn)",
            runtime = "(rntm)",
            source = "(src)",
            start = "",
            task = "(task)",
        },
    },
})
