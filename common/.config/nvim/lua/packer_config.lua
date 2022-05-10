-- luacheck: globals vim
local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

vim.cmd("packadd packer.nvim")
local packer = require("packer")

packer.init({
    compile_path = vim.fn.stdpath("data")
        .. "/site/pack/packer_generated/start"
        .. "/packer_generated/lua/packager_compiled.lua",
    disable_commands = true,
    -- profile = {
    --     enable = true,
    --     threshold = 0,
    -- },
})

local function install_treesitter_parsers()
    local treesitter_install = require("nvim-treesitter.install")

    treesitter_install.ensure_installed("all")
    vim.cmd(":TSUpdate")
end

packer.startup(function(use)
    use({ "wbthomason/packer.nvim", opt = true })

    -- Operators
    use({ "christoomey/vim-sort-motion", keys = "gs" })
    use({ "tpope/vim-commentary" }) -- gc

    use({
        "junegunn/vim-easy-align",
        requires = { "tpope/vim-repeat" },
        config = function()
            require("plugins.easy_align")
        end,
    }) -- gl

    use({
        "arthurxavierx/vim-caser",
        keys = "gyc",
        setup = function()
            vim.g.caser_prefix = "gyc"
        end,
    })

    -- https://joereynoldsaudio.com/2020/01/22/vim-sandwich-is-better-than-surround.html
    -- highlights the area it's operating on.
    use({
        "machakann/vim-sandwich",
        config = function()
            require("plugins.sandwich")
        end,
    }) -- sa, sd, sr

    -- Commands and key bindings
    use({ "tpope/vim-eunuch" })
    use({ "tyru/capture.vim", cmd = "Capture" })

    use({
        "chentau/marks.nvim",
        config = function()
            require("plugins.marks")
        end,
    })

    use({
        "bergercookie/vim-debugstring",
        requires = { "tpope/vim-repeat" },
        config = function()
            require("plugins.debugstring")
        end,
    }) -- dq

    use({
        "tpope/vim-unimpaired",
        requires = { "tpope/vim-repeat" },
    }) -- quite slow

    use({
        "junegunn/fzf.vim",
        requires = { "junegunn/fzf", run = "./install --bin" },
        config = function()
            require("plugins.fzf")
        end,
    })

    -- Navigation and Window Management
    use({ "sedm0784/vim-resize-mode", keys = "<C-W>" })

    use({
        "elihunter173/dirbuf.nvim",
        config = function()
            require("plugins.dirbuf")
        end,
    })

    -- Git and diffing
    use({ "whiteinge/diffconflicts", opt = true }) -- invoked by `git mergetool`
    use({ "will133/vim-dirdiff", cmd = "DirDiff" })

    -- Silent enhancement
    use({ "ellisonleao/gruvbox.nvim" })
    use({ "tpope/vim-sleuth" })
    use({ "vladdoster/remember.nvim" })

    use({
        "andymass/vim-matchup",
        config = function()
            require("plugins.matchup")
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("plugins.colorizer")
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        requires = { "tpope/vim-repeat" },
        config = function()
            require("plugins.gitsigns")
        end,
    }) -- gb

    use({
        "lewis6991/spaceless.nvim",
        config = function()
            require("spaceless").setup()
        end,
    })

    -- Syntax
    use({ "gisphm/vim-gitignore" })
    use({ "qnighy/vim-ssh-annex" })
    use({ "fatih/vim-go", opt = true }) -- Used for hugo layouts

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        opt = true,
        config = function()
            require("plugins.markdown_preview")
        end,
    })

    -- Treesitter
    use({ "RRethy/nvim-treesitter-endwise" })
    use({ "mfussenegger/nvim-treehopper" })
    use({ "nvim-treesitter/nvim-treesitter-refactor" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = install_treesitter_parsers,
        config = function()
            require("plugins.treesitter")
        end,
    })

    use({
        "ThePrimeagen/refactoring.nvim",
        config = function()
            require("plugins.refactoring")
        end,
        keys = "gyr",
    })

    -- LSP and null-ls
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    }) -- gyq, gQ, cx

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.null_ls")
        end,
    })

    -- My plugins/forks
    use({ "git@github.com:andrewferrier/vim-wrapping-softhard" })
end)

return packer
