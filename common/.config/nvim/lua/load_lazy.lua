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

require("lazy").setup("lazy-plugin-spec", {
    lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
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
        },
        -- Required to make built-in NeoVim packs work
        reset_packpath = false,
    },
    change_detection = {
        enabled = false,
        notify = false,
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
