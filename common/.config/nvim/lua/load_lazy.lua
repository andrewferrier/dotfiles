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
                "zipPlugin",

                -- These lines are needed to avoid opening directories from command line in
                -- netrw: https://github.com/elihunter173/dirbuf.nvim#notes
                "netrw",
                "netrwPlugin",
            },
        },
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
})

vim.cmd(
    "source "
        .. vim.env.VIMRUNTIME
        .. "/pack/dist/opt/cfilter/plugin/cfilter.vim"
)
