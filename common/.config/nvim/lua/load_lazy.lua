local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
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
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
        },
    },
})
